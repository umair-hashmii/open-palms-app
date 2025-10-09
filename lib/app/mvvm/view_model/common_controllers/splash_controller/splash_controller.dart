import 'dart:developer';
import 'package:get/get.dart';

import '../../../../config/app_routes.dart';
import '../../../../config/global_variables.dart';
import '../../../../services/logger_service.dart';
import '../../../../services/shared_preferences_service.dart';
import '../../../model/api_reponse/login_resp_model.dart';

class SplashController extends GetxController {
  var isLoading = true.obs;
  AppUser? userData;

  Future<void> checkUserData(context) async {
    try {
      isLoading.value = true;
      userData = await SharedPreferencesService().readUserData();
      if (userData == null) {
        Get.offAllNamed(AppRoutes.getStartedView);
      } else {
        log(userData?.toJson().toString() ?? 'No user data found');
        LoggerService.i('User email: ${userData!.email}');
        if (userData!.role == 'user') {
          GlobalVariables.userType = UserType.donor;
          Get.offNamed(AppRoutes.donorBottomBarView);
        } else {
          GlobalVariables.userType = UserType.needy;
          Get.offNamed(AppRoutes.needyHomeView);
        }
      }
    } catch (e, stackTrace) {
      LoggerService.e('Error during user data check: $e, Stack $stackTrace');
      Get.offAllNamed(AppRoutes.getStartedView);
    } finally {
      isLoading.value = false;
    }
  }
}
