import 'package:get/get.dart';

import '../../../repository/donor_requests_repo/donor_requests_repo.dart';
import '../../../services/logger_service.dart';
import '../../model/api_reponse/api_response.dart';
import '../../model/api_reponse/get_request_by_id_resp_model.dart';

class DonorHistoryController extends GetxController {
  RxBool isHistoryLoading = false.obs;
  List<GetAllRequestResponse> activeRequests = [];

  Future<bool> fetchHistory() async {
    isHistoryLoading.value = true;
    try {
      activeRequests.clear();
      ApiResponse<List<GetAllRequestResponse>> apiResponse = await DonorRequestsRepository().getAllRequests('completed', 'all');
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
      isHistoryLoading.value = false;
    }
  }
}
