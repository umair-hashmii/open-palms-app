import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repository/auth_repo/auth_repo.dart';
import '../../../../services/logger_service.dart';
import '../../../model/api_reponse/api_response.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  Future<bool> forgotPassword() async {
    try {
      ApiResponse<void>? apiResponse = await AuthRepository().forgotPasswordApi(emailController.text);
      if (apiResponse.success != null && apiResponse.success!) {
        LoggerService.i(apiResponse.message ?? 'No message from server');
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
}
