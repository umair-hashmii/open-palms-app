import 'package:get/get.dart';
import 'package:open_palms/app/mvvm/model/api_reponse/get_request_by_id_resp_model.dart';
import '../../../../repository/auth_repo/auth_repo.dart';
import '../../../../repository/donor_requests_repo/donor_requests_repo.dart';
import '../../../../services/logger_service.dart';
import '../../../../services/shared_preferences_service.dart';
import '../../../model/api_reponse/api_response.dart';
import '../../../model/api_reponse/login_resp_model.dart';
import '../../../model/api_reponse/request_resp_model.dart';

class DonorHomeController extends GetxController {
  RxBool isUserLoading = false.obs;
  RxBool isActiveRequestLoading = false.obs;
  AppUser? user;
  RxString selectedCategory = 'All'.obs;
  final List<String> categoryList = ["All", "Medical", "Education", "Emergency", "Community", "Family", "Other"];
  List<GetAllRequestResponse> activeRequests = [];

  void selectCategory(val) {
    selectedCategory.value = val;
  }

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
    final category = selectedCategory.value.toLowerCase();
    try {
      activeRequests.clear();
      ApiResponse<List<GetAllRequestResponse>> apiResponse = await DonorRequestsRepository().getAllRequests('active', category);
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
}
