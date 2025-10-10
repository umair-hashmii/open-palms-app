import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/custom_app_bar.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/donor_side_controllers/donor_history_controller.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/app_text_style.dart';
import '../../../../customWidgets/custom_loader.dart';
import '../../../../customWidgets/custom_tiles/request_custom_tile.dart';

class DonorHistoryView extends StatefulWidget {
  const DonorHistoryView({super.key});

  @override
  State<DonorHistoryView> createState() => _DonorHistoryViewState();
}

class _DonorHistoryViewState extends State<DonorHistoryView> {
  final DonorHistoryController controller = Get.find();

  @override
  void initState() {
    controller.fetchHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'History', backgroundColor: Colors.transparent, centerTitle: false, leading: SizedBox.shrink(), leadingWidth: 10.w),
      body: Obx(() {
        return controller.isHistoryLoading.value
            ? Center(child: CustomLoader())
            : controller.activeRequests.isEmpty
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
                        await controller.fetchHistory();
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
                itemCount: controller.activeRequests.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = controller.activeRequests[index];
                  return RequestCustomTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.donorRequestDetailView, arguments: {'requestId': item.id});
                    },
                    title: item.title,
                    image: item.images?[0],
                    collectedAmount: item.currentAmount.toString(),
                    priority: item.priority,
                    description: item.description,
                    supporters: "500",
                    totalAmount: item.targetAmount.toString(),
                  ).paddingBottom(10.h).animate().fadeIn(duration: 600.ms, delay: (200 * index).ms).slideY(begin: 0.15, end: 0);
                },
              );
      }).paddingHorizontal(15.w),
    );
  }
}
