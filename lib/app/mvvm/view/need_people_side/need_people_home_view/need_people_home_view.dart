import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/custom_loader.dart';
import 'package:open_palms/app/customWidgets/custom_tiles/active_request_tile.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/needy_side_controllers/needy_home_controller.dart';

import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/app_text_style.dart';
import '../../../../customWidgets/custom_cache_image/custom_cached_image.dart';
import '../../../../customWidgets/custom_tiles/request_custom_tile.dart';

class NeedPeopleHomeView extends StatefulWidget {
  const NeedPeopleHomeView({super.key});

  @override
  State<NeedPeopleHomeView> createState() => _NeedPeopleHomeViewState();
}

class _NeedPeopleHomeViewState extends State<NeedPeopleHomeView> {
  final NeedyHomeController controller = Get.find();

  @override
  void initState() {
    controller.fetchUserData();
    controller.fetchActiveRequest();
    controller.fetchCompletedRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.createRequestView);
              },
              child: Image.asset(AppAssets.addRequestIcon, height: 75.h),
            ),
          ],
        ),
      ).paddingRight(15.w),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Obx(() {
        return controller.isUserLoading.value
            ? Center(child: CustomLoader())
            : Column(
                children: [
                  40.h.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.donorProfileView);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.primaryLight, width: 1.5),
                              ),
                              child: CustomCachedImage(
                                height: 50.sp,
                                width: 50.sp,
                                imageUrl: controller.user?.profilePicture ?? '',
                                borderRadius: 100.sp,
                                name: "${controller.user?.firstName ?? ''} ${controller.user?.lastName ?? ''}",
                              ).paddingFromAll(2.sp),
                            ),
                          ),
                          10.w.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back!',
                                style: AppTextStyles.customText14(color: AppColors.textSecondary.withOpacity(0.6), fontWeight: FontWeight.w500),
                              ),
                              3.h.height,
                              Text(
                                "${controller.user?.firstName ?? ''} ${controller.user?.lastName ?? ''}",
                                style: AppTextStyles.customText18(color: AppColors.black, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.notificationsView);
                            },
                            child: Image.asset(AppAssets.notificationIcon, height: 25.h),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: SafeArea(
                      child: RefreshIndicator(
                        color: AppColors.primary,
                        onRefresh: () async {
                          await controller.fetchUserData();
                          await controller.fetchActiveRequest();
                          await controller.fetchCompletedRequest();
                        },
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage(AppAssets.liningBg), fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8.sp),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        5.h.height,
                                        Text('Total Received', style: AppTextStyles.customText14(color: Colors.white.withOpacity(0.6))),
                                        5.h.height,
                                        Text(
                                          '\$7550.00',
                                          style: AppTextStyles.customText26(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ).paddingFromAll(13.sp),
                                  ],
                                ),
                              ),
                              15.h.height,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Active',
                                  style: AppTextStyles.customText22(color: AppColors.black, fontWeight: FontWeight.w600),
                                ),
                              ),
                              10.h.height,
                              Obx(() {
                                return controller.isActiveRequestLoading.value
                                    ? Center(child: CustomLoader())
                                    : controller.activeRequests.isEmpty
                                    ? Center(
                                        child: Column(
                                          children: [
                                            80.h.height,
                                            Icon(Icons.info_outline_rounded, color: AppColors.negativeRed, size: 30.sp),
                                            8.h.height,
                                            Text(
                                              'No Active Request Found!',
                                              style: AppTextStyles.customText20(color: Colors.black, fontWeight: FontWeight.w500),
                                            ),
                                            8.h.height,
                                            GestureDetector(
                                              onTap: () async {
                                                await controller.fetchActiveRequest();
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
                                    : GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.needyRequestDetailView, arguments: {'requestId': controller.activeRequests[0].id});
                                        },
                                        child: ActiveRequestTile(
                                          title: controller.activeRequests[0].title,
                                          supporters: controller.activeRequests[0].donationCount.toString(),
                                          description: controller.activeRequests[0].description,
                                          image: controller.activeRequests[0].images?[0],
                                          collectedPayment: controller.activeRequests[0].currentAmount.toString(),
                                          totalPayment: controller.activeRequests[0].targetAmount.toString(),
                                          priority: controller.activeRequests[0].priority,
                                        ),
                                      );
                              }),
                              15.h.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Request History',
                                    style: AppTextStyles.customText22(color: AppColors.black, fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.needyRequestHistoryView);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'See All',
                                          style: AppTextStyles.customText14(color: AppColors.black, fontWeight: FontWeight.w500),
                                        ),
                                        4.w.width,
                                        SvgPicture.asset(AppAssets.seeAllIcon),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              10.h.height,
                              Obx(() {
                                return controller.isCompletedRequestLoading.value
                                    ? Center(child: CustomLoader()).paddingTop(80.h)
                                    : controller.completedRequests.isEmpty
                                    ? Center(
                                        child: Column(
                                          children: [
                                            80.h.height,
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
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
      }).paddingHorizontal(15.w),
    );
  }
}
