import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/mvvm/model/api_reponse/get_request_by_id_resp_model.dart';

import '../../../repository/needy_requests_repo/needy_requests_repo.dart';
import '../../../services/logger_service.dart';
import '../../model/api_reponse/api_response.dart';

class NeedyRequestDetailController extends GetxController {
  GetRequestByIdRespModel? requestDetail;
  RxBool isDetailLoading = false.obs;

  Future<bool> getRequestDetails(String requestId) async {
    isDetailLoading.value = true;
    try {
      ApiResponse<GetRequestByIdRespModel> apiResponse = await NeedyRequestsRepository().getRequestById(requestId);
      if (apiResponse.success != null && apiResponse.success!) {
        requestDetail = apiResponse.data;
        return true;
      } else {
        return false;
      }
    } catch (e, stack) {
      LoggerService.e('Error during fetching user data: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isDetailLoading.value = false;
    }
  }

  double calculatePercentage(String? totalAmount, String? collectedAmount) {
    if (totalAmount == null || collectedAmount == null) return 0;
    final total = double.tryParse(totalAmount) ?? 0;
    final collected = double.tryParse(collectedAmount) ?? 0;
    if (total <= 0) return 0;
    final percentage = (collected / total) * 100;
    return double.parse(percentage.toStringAsFixed(2));
  }

  /// Already existing
  var currentIndex = 0.obs;
  PageController? pageController;

  /// Already existing
  void changeImage(int index) {
    currentIndex.value = index;
  }
}
