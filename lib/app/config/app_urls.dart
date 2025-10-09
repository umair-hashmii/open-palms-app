/// Defines API endpoints for the LayerX app.
abstract class AppUrls {
  AppUrls._();

  static const String baseAPIURL = 'https://openpalms.jeuxvps.com/api';

  // static const String notificationsBaseApi = "https://fcm.googleapis.com/v1/projects/ninjacar-3cb70/messages:send";

  // Auth Apis
  static const String signUp = '/auth/register';
  static const String login = '/auth/login';
  static const String getProfile = '/auth/profile';
  static const String forgotPassword = '/auth/forgot-password';
}
