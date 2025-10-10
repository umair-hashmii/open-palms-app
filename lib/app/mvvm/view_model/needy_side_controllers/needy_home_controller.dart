import 'package:get/get.dart';
import 'package:open_palms/app/mvvm/model/api_reponse/request_resp_model.dart';
import 'package:open_palms/app/repository/needy_requests_repo/needy_requests_repo.dart';
import '../../../repository/auth_repo/auth_repo.dart';
import '../../../services/logger_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../model/api_reponse/api_response.dart';
import '../../model/api_reponse/login_resp_model.dart';

class NeedyHomeController extends GetxController {
  RxBool isUserLoading = false.obs;
  RxBool isActiveRequestLoading = false.obs;
  RxBool isCompletedRequestLoading = false.obs;
  AppUser? user;
  List<RequestRespModel> activeRequests = [];
  List<RequestRespModel> completedRequests = [];

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

  Future<bool> fetchActiveRequest() async {
    isActiveRequestLoading.value = true;
    try {
      activeRequests.clear();
      ApiResponse<List<RequestRespModel>> apiResponse = await NeedyRequestsRepository().getMyRequests('active');
      if (apiResponse.success != null && apiResponse.success!) {
        activeRequests = apiResponse.data ?? [];
        return true;
      } else {
        return false;
      }
    } catch (e, stack) {
      LoggerService.e('Error during fetching user data: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isActiveRequestLoading.value = false;
    }
  }

  Future<bool> fetchCompletedRequest() async {
    isCompletedRequestLoading.value = true;
    try {
      completedRequests.clear();
      ApiResponse<List<RequestRespModel>> apiResponse = await NeedyRequestsRepository().getMyRequests('completed');
      if (apiResponse.success != null && apiResponse.success!) {
        completedRequests = apiResponse.data ?? [];
        return true;
      } else {
        return false;
      }
    } catch (e, stack) {
      LoggerService.e('Error during fetching user data: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isCompletedRequestLoading.value = false;
    }
  }
}
