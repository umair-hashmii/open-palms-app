import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart'; // ⬅️ for pooled IOClient + per-request cancel
import '../config/app_urls.dart';
import '../config/global_variables.dart';
import '../mvvm/model/body_model/sign_up_body_model.dart';
import 'global_variables.dart';
import 'internet_service.dart';
import 'logger_service.dart';
import 'shared_preferences_service.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

/// Cancellation token to abort requests (now notifies listeners).
class CancelToken {
  bool _canceled = false;
  String? reason;
  final Completer<void> _notifier = Completer<void>();

  bool get isCanceled => _canceled;

  Future<void> get whenCanceled => _notifier.future;

  void cancel([String? reason]) {
    if (_canceled) return;
    _canceled = true;
    this.reason = reason;
    if (!_notifier.isCompleted) _notifier.complete();
  }
}

class HttpsCalls {
  // ===== Connection pooling (shared) =====
  // Reuse sockets, honor keep-alive, gzip, lower CPU per call.
  late final IOClient _pooledClient = () {
    final h = HttpClient()
      ..idleTimeout = const Duration(seconds: 15)
      ..connectionTimeout = const Duration(seconds: 15)
      ..maxConnectionsPerHost = 8
      ..autoUncompress = true; // gzip/deflate
    return IOClient(h);
  }();

  // Concurrency limiter (protect UI + sockets under burst load)
  final int _maxConcurrency = 8; // tune per app/profile
  int _active = 0;
  final Queue<Completer<void>> _waiters = Queue<Completer<void>>();

  Future<void> _acquireSlot() async {
    if (_active < _maxConcurrency) {
      _active++;
      return;
    }
    final c = Completer<void>();
    _waiters.addLast(c);
    await c.future;
    // slot granted
  }

  void _releaseSlot() {
    if (_waiters.isNotEmpty) {
      _waiters.removeFirst().complete();
    } else {
      _active = (_active > 0) ? _active - 1 : 0;
    }
  }

  final _ongoingRequests = <String, Future<http.Response>>{};
  final Duration _timeoutDuration = const Duration(seconds: 25);
  final int _maxRetries = 3;
  final _random = Random();

  Future<http.Response> _performRequest(String key, Future<http.Response> Function(http.Client client) request, {CancelToken? cancelToken}) async {
    final hasInternet = await InternetService.hasWorkingInternet();
    LoggerService.d('Internet status: $hasInternet');

    if (!hasInternet) {
      GlobalVariables.errorMessages = ["No internet connection"];
      return http.Response('No internet connection', 503);
    }

    // Join duplicate in-flight requests
    if (_ongoingRequests.containsKey(key)) {
      return _ongoingRequests[key]!;
    }

    await _acquireSlot(); // throttle concurrency
    try {
      // Use pooled client by default; if cancelable, spin a dedicated client we can close.
      IOClient? perRequestClient;
      http.Client client;
      if (cancelToken != null) {
        final h = HttpClient()
          ..idleTimeout = const Duration(seconds: 15)
          ..connectionTimeout = const Duration(seconds: 15)
          ..maxConnectionsPerHost = 8
          ..autoUncompress = true;
        perRequestClient = IOClient(h);
        client = perRequestClient;
      } else {
        client = _pooledClient;
      }

      // Retry loop
      for (int attempt = 0; attempt <= _maxRetries; attempt++) {
        if (cancelToken?.isCanceled == true) {
          LoggerService.w('Request cancelled for $key: ${cancelToken?.reason}');
          perRequestClient?.close();
          throw Exception('Request cancelled: ${cancelToken?.reason ?? ""}');
        }

        try {
          final future = request(client).timeout(_timeoutDuration);

          // If we need mid-flight cancel: race the response with cancel signal.
          final response = (cancelToken == null)
              ? await (_ongoingRequests[key] = future)
              : await (_ongoingRequests[key] = Future.any([
                  future,
                  cancelToken.whenCanceled.then((_) => throw Exception('Request cancelled: ${cancelToken.reason ?? ""}')),
                ]));

          _ongoingRequests.remove(key);
          LoggerService.i('Request succeeded for $key');
          // Close per-request client AFTER success to free sockets
          perRequestClient?.close();
          return response;
        } on TimeoutException catch (e) {
          if (attempt == _maxRetries) {
            _ongoingRequests.remove(key);
            perRequestClient?.close();
            LoggerService.e('Request timed out after $_maxRetries retries: $e');
            throw Exception('Timeout after $_maxRetries retries');
          }
          await _retryDelay(attempt);
        } on Exception catch (e, st) {
          // If cancelled mid-flight, the close() causes a ClientException → treat as cancel
          if (cancelToken?.isCanceled == true || e.toString().contains('Request cancelled')) {
            _ongoingRequests.remove(key);
            perRequestClient?.close();
            LoggerService.w('Canceled $key: $e');
            rethrow;
          }

          if (attempt == _maxRetries) {
            _ongoingRequests.remove(key);
            perRequestClient?.close();
            LoggerService.e('Request failed after $_maxRetries retries: $e', error: e, stackTrace: st);
            throw Exception('Failed after retries: $e');
          }
          await _retryDelay(attempt);
        }
      }

      // Shouldn’t reach here
      _ongoingRequests.remove(key);
      perRequestClient?.close();
      throw Exception('Failed to perform request');
    } finally {
      _releaseSlot();
    }
  }

  Future<void> _retryDelay(int attempt) async {
    final base = pow(2, attempt).toInt();
    final jitter = _random.nextInt(400); // smaller jitter for snappier UX
    await Future.delayed(Duration(milliseconds: base * 500 + jitter));
  }

  Future<Map<String, String>> _getDefaultHeaders() async {
    final token = await SharedPreferencesService().readToken();
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  Future<http.Response> _sendRequest(http.Client client, HttpMethod method, String lControllerUrl, {List<int>? body}) async {
    final headers = await _getDefaultHeaders();
    final url = Uri.parse(AppUrls.baseAPIURL + lControllerUrl);
    LoggerService.d('Sending $method request to $url');

    switch (method) {
      case HttpMethod.GET:
        return await client.get(url, headers: headers);
      case HttpMethod.POST:
        return await client.post(url, headers: headers, body: body);
      case HttpMethod.PUT:
        return await client.put(url, headers: headers, body: body);
      case HttpMethod.PATCH:
        return await client.patch(url, headers: headers, body: body);
      case HttpMethod.DELETE:
        return await client.delete(url, headers: headers, body: body);
    }
  }

  Future<http.Response> getApiHits(String lControllerUrl, {CancelToken? cancelToken}) {
    return _performRequest(lControllerUrl, (client) => _sendRequest(client, HttpMethod.GET, lControllerUrl), cancelToken: cancelToken);
  }

  Future<http.Response> postApiHits(String lControllerUrl, List<int>? lUtfContent, {CancelToken? cancelToken}) {
    return _performRequest(lControllerUrl, (client) => _sendRequest(client, HttpMethod.POST, lControllerUrl, body: lUtfContent), cancelToken: cancelToken);
  }

  Future<http.Response> putApiHits(String lControllerUrl, List<int> lUtfContent, {CancelToken? cancelToken}) {
    return _performRequest(lControllerUrl, (client) => _sendRequest(client, HttpMethod.PUT, lControllerUrl, body: lUtfContent), cancelToken: cancelToken);
  }

  Future<http.Response> patchApiHits(String lControllerUrl, List<int> lUtfContent, {CancelToken? cancelToken}) {
    return _performRequest(lControllerUrl, (client) => _sendRequest(client, HttpMethod.PATCH, lControllerUrl, body: lUtfContent), cancelToken: cancelToken);
  }

  Future<http.Response> deleteApiHits(String lControllerUrl, {List<int>? lUtfContent, CancelToken? cancelToken}) {
    return _performRequest(lControllerUrl, (client) => _sendRequest(client, HttpMethod.DELETE, lControllerUrl, body: lUtfContent), cancelToken: cancelToken);
  }

  Future<http.Response> _genericMultipartRequest(
    http.Client client,
    String endpointUrl,
    dynamic model, {
    Map<String, dynamic Function()>? fileExtractors,
    String? type,
  }) async {
    final token = await SharedPreferencesService().readToken();
    final url = Uri.parse(AppUrls.baseAPIURL + endpointUrl);
    final request = http.MultipartRequest(type ?? 'POST', url);

    // Do NOT set content-type manually for multipart; package:http handles boundary.
    request.headers.addAll({HttpHeaders.acceptHeader: 'application/json', if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token'});

    final json = model.toJson();
    json.forEach((key, value) {
      if (value == null) return;
      if (value is List) {
        for (int i = 0; i < value.length; i++) {
          request.fields['$key[$i]'] = value[i].toString();
        }
      } else if (value is String || value is num || value is bool) {
        request.fields[key] = value.toString();
      }
    });

    if (fileExtractors != null) {
      for (var entry in fileExtractors.entries) {
        final fKey = entry.key;
        final v = entry.value();
        if (v is File) {
          request.files.add(await http.MultipartFile.fromPath(fKey, v.path));
        } else if (v is List<File>) {
          for (final f in v) {
            request.files.add(await http.MultipartFile.fromPath(fKey, f.path));
          }
        }
      }
    }

    LoggerService.d('Sending multipart request to $endpointUrl');
    final streamedResponse = await client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> signUpMultiPart(String lControllerUrl, SignUpBodyModel signUpBodyModel, {CancelToken? cancelToken}) {
    return _performRequest(
      lControllerUrl,
      (client) => _genericMultipartRequest(
        client,
        lControllerUrl,
        signUpBodyModel,
        fileExtractors: {'profilePicture': () => signUpBodyModel.profilePicture, 'identityDocuments': () => signUpBodyModel.identityImages},
      ),
      cancelToken: cancelToken,
    );
  }

  // Future<http.Response> updateMultiPart(String lControllerUrl, SignUpBodyModel signUpBodyModel, {CancelToken? cancelToken}) {
  //   return _performRequest(
  //     lControllerUrl,
  //         (client) => _genericMultipartRequest(
  //       client,
  //       lControllerUrl,
  //       signUpBodyModel,
  //       type: 'PUT',
  //       fileExtractors: {'profilePicture': () => signUpBodyModel.profilePicture, 'additionalPics': () => signUpBodyModel.additionalPics},
  //     ),
  //     cancelToken: cancelToken,
  //   );
  // }
}
