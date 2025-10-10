import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../repository/auth_repo/auth_repo.dart';
import '../../../../services/logger_service.dart';
import '../../../../services/shared_preferences_service.dart';
import '../../../model/api_reponse/api_response.dart';
import '../../../model/api_reponse/login_resp_model.dart';

class ProfileController extends GetxController {
  RxBool isUserLoading = false.obs;
  AppUser? user;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  fncReadSp() async {
    isUserLoading.value = true;
    user = await SharedPreferencesService().readUserData();
  }

  Future<bool> fetchUserData() async {
    isUserLoading.value = true;
    try {
      await fncReadSp();
      ApiResponse<AppUser> apiResponse = await AuthRepository().getUserByID(user?.id ?? '0');
      if (apiResponse.success != null && apiResponse.success!) {
        user = apiResponse.data;
        firstNameController.text = user?.firstName ?? '';
        lastNameController.text = user?.lastName ?? '';
        emailController.text = user?.email ?? '';
        await SharedPreferencesService().saveUserData(user!);
        return true;
      } else {
        return false;
      }
    } catch (e, stack) {
      LoggerService.e('Error during fetching user data: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isUserLoading.value = false;
    }
  }
}
