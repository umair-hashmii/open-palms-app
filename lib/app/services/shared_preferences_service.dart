import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../mvvm/model/api_reponse/login_resp_model.dart';
import 'logger_service.dart';

/// Service for managing local storage using SharedPreferences.
class SharedPreferencesService {
  static const String _keyDataModel = 'data_model';
  static const String _keyUserData = 'user_data';
  static const String _deviceToken = 'deviceToken';
  static const String _apiToken = 'apiToken';
  static const String _languageLocale = 'languageLocale';

  Future<void> saveDeviceToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceToken, token);
    LoggerService.i('Saved device token');
  }

  Future<String?> readDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_deviceToken);
    LoggerService.d('Read device token: $token');
    return token;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiToken, token);
    LoggerService.i('Saved API token');
  }

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_apiToken);
    LoggerService.d('Read API token: $token');
    return token;
  }

  Future<void> saveUserData(AppUser userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(userData.toJson());
    await prefs.setString(_keyUserData, data);
  }

  Future<AppUser?> readUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(_keyUserData);
    if (data != null) {
      Map<String, dynamic> jsonData = json.decode(data);
      return AppUser.fromJson(jsonData);
    }
    return null;
  }

  // static Future<void> saveLocaleLanguage(NinjaLangModel locale) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final data = json.encode(locale.toJson());
  //   await prefs.setString(_languageLocale, data);
  // }

  // static Future<NinjaLangModel?> readLanguageLocale() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? data = prefs.getString(_languageLocale);
  //   if (data != null) {
  //     final jsonData = json.decode(data);
  //     return NinjaLangModel.fromJson(jsonData);
  //   }
  //   return null;
  // }

  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.clear();
    if (result) {
      LoggerService.i('All SharedPreferences data cleared successfully');
    } else {
      LoggerService.e('Failed to clear SharedPreferences data');
    }
  }
}
