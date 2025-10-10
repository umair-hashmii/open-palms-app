import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/custom_app_bar.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/needy_side_controllers/needy_home_controller.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/app_text_style.dart';
import '../../../../customWidgets/custom_loader.dart';
import '../../../../customWidgets/custom_tiles/request_custom_tile.dart';

class NeedyRequestHistoryView extends StatefulWidget {
  const NeedyRequestHistoryView({super.key});

  @override
  State<NeedyRequestHistoryView> createState() => _NeedyRequestHistoryViewState();
}

class _NeedyRequestHistoryViewState extends State<NeedyRequestHistoryView> {
  final NeedyHomeController controller = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCompletedRequest();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Request History', backgroundColor: Colors.transparent),
      body: Obx(() {
        return controller.isCompletedRequestLoading.value
            ? Center(child: CustomLoader())
            : controller.completedRequests.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline_rounded, color: AppColors.negativeRed, size: 30.sp),
                    8.h.height,
                    Text(
                      'No Requests History Found!',
                      style: AppTextStyles.customText20(color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    8.h.height,
                    GestureDetector(
                      onTap: () async {
                        await controller.fetchCompletedRequest();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh, color: AppColors.primary, size: 15.sp),
                          5.w.width,
                          Text('Tap here to Refresh', style: AppTextStyles.customText14(color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.completedRequests.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = controller.completedRequests[index];
                  return RequestCustomTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.needyRequestDetailView, arguments: {'requestId': item.id});
                    },
                    title: item.title,
                    image: item.images?[0],
                    collectedAmount: item.currentAmount.toString(),
                    priority: item.priority,
                    description: item.description,
                    supporters: item.donationCount.toString(),
                    totalAmount: item.targetAmount.toString(),
                  ).paddingBottom(10.h);
                },
              );
      }).paddingHorizontal(15.w),
    );
  }
}
