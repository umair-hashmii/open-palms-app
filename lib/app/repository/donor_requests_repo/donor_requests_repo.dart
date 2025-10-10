import 'dart:convert';
import 'package:open_palms/app/mvvm/model/api_reponse/get_request_by_id_resp_model.dart';
import 'package:open_palms/app/mvvm/model/api_reponse/request_resp_model.dart';
import 'package:open_palms/app/mvvm/model/body_model/create_donation_request_body_model.dart';

import '../../config/app_urls.dart';
import '../../mvvm/model/api_reponse/api_response.dart';
import '../../mvvm/model/api_reponse/login_resp_model.dart';
import '../../mvvm/model/body_model/login_body_model.dart';
import '../../mvvm/model/body_model/sign_up_body_model.dart';
import '../../services/api_response_handler.dart';
import '../../services/https_calls.dart';
import '../../services/logger_service.dart';
import 'package:http/http.dart' as http;

class DonorRequestsRepository {
  final HttpsCalls _httpsCalls = HttpsCalls();

  Future<ApiResponse<GetRequestByIdRespModel>> getRequestById(String requestId) async {
    try {
      final endPoint = AppUrls.createDonationRequest;
      final dynamicUrl = '$endPoint/$requestId';
      LoggerService.d('Initiating driver signup API call');
      final response = await _httpsCalls.getApiHits(dynamicUrl);
      return await ApiResponseHandler.process(response, endPoint, (dataJson) => GetRequestByIdRespModel.fromJson(dataJson));
    } catch (e, stackTrace) {
      ApiResponseHandler.logUnhandledError(e, stackTrace);
      rethrow;
    }
  }

  Future<ApiResponse<List<GetAllRequestResponse>>> getAllRequests(String status, String category) async {
    try {
      final endPoint = AppUrls.createDonationRequest;
      String? dynamicUrl;
      if (category != 'all') {
        dynamicUrl = '$endPoint?status=$status&category=$category';
      } else {
        dynamicUrl = '$endPoint?status=$status';
      }
      LoggerService.d('Initiating getMyRequests API call');
      final response = await _httpsCalls.getApiHits(dynamicUrl);
      return await ApiResponseHandler.process(response, endPoint, (dataJson) {
        if (dataJson is List) {
          return dataJson.map((e) => GetAllRequestResponse.fromJson(e)).toList();
        } else {
          return <GetAllRequestResponse>[];
        }
      });
    } catch (e, stackTrace) {
      ApiResponseHandler.logUnhandledError(e, stackTrace);
      rethrow;
    }
  }
}
