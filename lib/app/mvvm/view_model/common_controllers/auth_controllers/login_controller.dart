import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../config/global_variables.dart';
import '../../../../repository/auth_repo/auth_repo.dart';
import '../../../../services/logger_service.dart';
import '../../../../services/shared_preferences_service.dart';
import '../../../model/api_reponse/api_response.dart';
import '../../../model/api_reponse/login_resp_model.dart';
import '../../../model/body_model/login_body_model.dart';

class LoginController extends GetxController {
  RxBool isVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  void toggleConfirmPassword() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void togglePassword() {
    isVisible.value = !isVisible.value;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<LoginBodyModel> fncLoginBodyModel() async {
    // NotificationPermissions notificationPermissions = NotificationPermissions();
    // String? deviceTokens = await notificationPermissions.getDeviceToken();

    return LoginBodyModel(
      email: emailController.text,
      password: passwordController.text,
      role: GlobalVariables.userType == UserType.donor ? 'donor' : "recipient",
      deviceToken: "deviceTokens",
    );
  }

  Future<bool> login() async {
    try {
      LoginBodyModel loginBodyModel = await fncLoginBodyModel();
      ApiResponse<LoginResponseModel> apiResponse = await AuthRepository().loginApi(loginBodyModel);
      if (apiResponse.data != null) {
        await SharedPreferencesService().saveUserData(apiResponse.data?.user ?? AppUser());
        await SharedPreferencesService().saveToken(apiResponse.data?.token ?? "");
        if (apiResponse.data?.user?.role == 'donor') {
          GlobalVariables.userType = UserType.donor;
        } else {
          GlobalVariables.userType = UserType.needy;
        }
        LoggerService.i(apiResponse.message ?? 'No message from server');
        clearAllData();
        return true;
      } else {
        LoggerService.w('Signup response is null');
        return false;
      }
    } catch (e, stack) {
      LoggerService.e('Error during signup: $e', error: e, stackTrace: stack);
      return false;
    } finally {}
  }

  void clearAllData() {
    emailController.text = '';
    passwordController.text = '';
  }
}
