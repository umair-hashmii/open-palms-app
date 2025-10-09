import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:open_palms/app/config/app_assets.dart';
import 'package:open_palms/app/config/app_routes.dart';
import 'package:open_palms/app/config/app_text_style.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/custom_loader.dart';
import 'package:open_palms/app/customWidgets/custom_tiles/donor_stats_tile.dart';
import 'package:open_palms/app/customWidgets/custom_tiles/request_custom_tile.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/donor_side_controllers/donor_home_controller/donor_home_controller.dart';

import '../../../../config/app_colors.dart';
import '../../../../customWidgets/custom_cache_image/custom_cached_image.dart';

class DonorHomeView extends StatefulWidget {
  const DonorHomeView({super.key});

  @override
  State<DonorHomeView> createState() => _DonorHomeViewState();
}

class _DonorHomeViewState extends State<DonorHomeView> {
  final DonorHomeController controller = Get.find();

  @override
  void initState() {
    controller.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return controller.isUserLoading.value
            ? Center(child: CustomLoader())
            : Column(
                children: [
                  40.h.height,
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
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
                          10.w.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome!',
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
                        children: [
                          SvgPicture.asset(AppAssets.searchIcon),
                          15.w.width,
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.notificationsView);
                            },
                            child: Image.asset(AppAssets.notificationIcon, height: 25.h),
                          ),
                        ],
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),

                  Expanded(
                    child: SafeArea(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Stats Tile
                            DonorStatsTile(
                              badge: 'Bronze',
                              badgeValue: 2.0,
                              totalDonation: '4750.00',
                            ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2, end: 0),

                            15.h.height,

                            // Categories Text
                            Text(
                              'Categories',
                              style: AppTextStyles.customText22(color: AppColors.black, fontWeight: FontWeight.w600),
                            ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),

                            10.h.height,

                            // Categories List
                            SizedBox(
                              height: 40.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: controller.categoryList.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  final category = controller.categoryList[index];
                                  return GestureDetector(
                                    onTap: () => controller.selectCategory(category),
                                    child: Obx(() {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: controller.selectedCategory.value == category ? AppColors.primary : const Color(0xffF6F6F6),
                                          borderRadius: BorderRadius.circular(6.sp),
                                          border: Border.all(color: AppColors.black.withOpacity(0.06)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            category,
                                            style: AppTextStyles.customText16(
                                              fontWeight: FontWeight.w500,
                                              color: controller.selectedCategory.value == category ? AppColors.white : AppColors.black,
                                            ),
                                          ),
                                        ).paddingHorizontal(25.w),
                                      );
                                    }),
                                  ).animate().fadeIn(duration: 400.ms, delay: (100 * index).ms).scaleXY(begin: 0.9, end: 1);
                                },
                              ),
                            ),

                            15.h.height,

                            // Requests List
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return RequestCustomTile(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.donorRequestDetailView, arguments: {'status': 'active'});
                                  },
                                  title: "Emergency Medical Surgery",
                                  image: "https://images.pexels.com/photos/8078574/pexels-photo-8078574.jpeg",
                                  collectedAmount: "18750",
                                  priority: "High",
                                  description:
                                      "Help Sarah with urgent medical expenses for her heart surgery. She needs immediate support to cover hospital bills and post-operative care. Sarah is a single mother of two who has been battling heart disease for the past year.",
                                  supporters: '235',
                                  totalAmount: "25000",
                                ).paddingBottom(10.h).animate().fadeIn(duration: 600.ms, delay: (200 * index).ms).slideY(begin: 0.15, end: 0);
                              },
                            ),
                          ],
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
