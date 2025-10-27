import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:open_palms/app/config/app_colors.dart';
import 'package:open_palms/app/config/app_strings.dart';
import 'package:open_palms/app/config/global_variables.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/custom_app_bar.dart';
import 'package:open_palms/app/customWidgets/custom_bottom_sheets/delete_account_sheet.dart';
import 'package:open_palms/app/customWidgets/custom_bottom_sheets/edit_profile_sheet.dart';
import 'package:open_palms/app/customWidgets/custom_bottom_sheets/logout_sheet.dart';
import 'package:open_palms/app/customWidgets/custom_loader.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/auth_controllers/profile_controller.dart';
import 'package:open_palms/app/services/shared_preferences_service.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/app_text_style.dart';
import '../../../../config/utils.dart';

class DonorProfileView extends StatefulWidget {
  const DonorProfileView({super.key});

  @override
  State<DonorProfileView> createState() => _DonorProfileViewState();
}

class _DonorProfileViewState extends State<DonorProfileView> {
  bool notificationEnabled = true;
  double badgeValue = 2.0;
  final ProfileController controller = Get.find();

  @override
  void initState() {
    controller.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Account & Setting',
        centerTitle: GlobalVariables.userType == UserType.needy ? true : false,
        backgroundColor: Colors.transparent,
        leading: GlobalVariables.userType == UserType.needy ? null : SizedBox.shrink(),
        leadingWidth: GlobalVariables.userType == UserType.needy ? null : 10.w,
      ), // 👈 AppBar animation
      body: Obx(() {
        return controller.isUserLoading.value
            ? Center(child: CustomLoader())
            : SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(12.r),
                          image: GlobalVariables.userType == UserType.needy ? DecorationImage(image: AssetImage(AppAssets.liningBg), fit: BoxFit.cover) : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    10.h.height,
                                    Text(
                                      "${controller.user?.firstName ?? ''} ${controller.user?.lastName ?? ''}",
                                      style: AppTextStyles.customText18(color: Colors.white, fontWeight: FontWeight.w700),
                                    ),
                                    4.h.height,
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.messageIcon),
                                        4.w.width,
                                        Text(
                                          controller.user?.email ?? 'N/A',
                                          style: AppTextStyles.customText14(color: Colors.white, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Utils.showBottomSheet(context: context, child: EditProfileSheet());
                                  },
                                  child: SvgPicture.asset(AppAssets.editIcon),
                                ),
                              ],
                            ),
                            20.h.height,
                            SizedBox(
                              width: double.infinity,
                              child: SvgPicture.asset(AppAssets.dividerIc, fit: BoxFit.fitWidth),
                            ),
                            15.h.height,
                            if (GlobalVariables.userType == UserType.needy) ...[
                              Text('Total Received', style: AppTextStyles.customText14(color: Colors.white.withOpacity(0.6))),
                              5.h.height,
                              Text(
                                '\$7550.00',
                                style: AppTextStyles.customText26(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ] else ...[
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total Donation',
                                            style: AppTextStyles.customText16(color: AppColors.white.withOpacity(0.9), fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '\$${controller.user?.statistics?.totalDonated}',
                                            style: AppTextStyles.customText28(color: AppColors.white, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.sp)),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Image.asset(AppAssets.bronzeBadge, height: 25.h),
                                              Text(
                                                'Bronze',
                                                style: AppTextStyles.customText14(color: AppColors.black, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ).paddingHorizontal(10.w).paddingVertical(8.h),
                                      ),
                                    ],
                                  ),
                                  15.h.height,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6.sp),
                                      border: Border.all(color: const Color(0xffE5E5E5)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Bronze',
                                              style: AppTextStyles.customText18(color: Colors.black, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'Silver',
                                              style: AppTextStyles.customText18(color: Colors.black, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        10.h.height,
                                        SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            activeTrackColor: AppColors.primary,
                                            inactiveTrackColor: AppColors.textLightBlack.withOpacity(0.1),
                                            thumbColor: Colors.green,
                                            trackHeight: 6.0,
                                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                            overlayColor: AppColors.primary,
                                            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                                          ),
                                          child: Slider(
                                            padding: EdgeInsets.zero,
                                            value: badgeValue,
                                            min: 0.0,
                                            max: 10.0,
                                            divisions: 100,
                                            onChanged: (double value) {},
                                          ),
                                        ),
                                      ],
                                    ).paddingFromAll(10.sp),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0), // 👈 Profile card animation

                      25.h.height,

                      Text(
                        "Other setting",
                        style: AppTextStyles.customText16(color: AppColors.grey, fontWeight: FontWeight.w600),
                      ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(begin: -0.2, end: 0), // 👈 Section heading animation

                      15.h.height,

                      // Settings container
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(13.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3))],
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [..._animatedSettingsTiles(context)]),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  /// Animated list of setting tiles
  List<Widget> _animatedSettingsTiles(BuildContext context) {
    final tiles = <Widget>[
      _settingsTile(
        leading: Image.asset(AppAssets.notificationIc, height: 43.h, width: 43.w),
        title: "Notifications",
        trailing: Container(
          width: 40.w,
          alignment: Alignment.centerRight,
          child: Transform.scale(
            scale: 0.7,
            child: Switch(
              value: notificationEnabled,
              activeColor: AppColors.primary,
              inactiveThumbColor: AppColors.secondary,
              inactiveTrackColor: Color(0xFFF3F3F7),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              onChanged: (val) {
                setState(() {
                  notificationEnabled = val;
                });
              },
            ),
          ),
        ),
        onTap: () {},
      ),
      if (GlobalVariables.userType == UserType.donor)
        _settingsTile(
          leading: SvgPicture.asset(AppAssets.subscriptionIcon, height: 43.h, width: 43.w),
          title: "Subscription",
          trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
          onTap: () {
            Get.toNamed(AppRoutes.subscriptionView);
          },
        ),
      _settingsTile(
        leading: Image.asset(AppAssets.aboutUsIcon, height: 43.h, width: 43.w),
        title: "About Us",
        trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
        onTap: () {
          Get.toNamed(AppRoutes.aboutUsView);
        },
      ),
      _settingsTile(
        leading: Image.asset(AppAssets.privacyIcon, height: 43.h, width: 43.w),
        title: "Privacy Policy",
        trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
        onTap: () {
          Get.toNamed(AppRoutes.privacyPolicyView);
        },
      ),
      _settingsTile(
        leading: Image.asset(AppAssets.signOutIcon, height: 43.h, width: 43.w),
        title: "Sign out",
        trailing: SizedBox.shrink(),
        onTap: () {
          Utils.showBottomSheet(
            context: context,
            child: LogoutSheet(
              onLogoutTap: () async {
                Get.dialog(CustomLoader(), barrierDismissible: false);
                bool isLogout = await controller.logoutApi();
                Get.back();
                if (isLogout) {
                  Get.offAllNamed(AppRoutes.userSelectionView);
                } else {}
              },
            ),
          );
        },
      ),
      _settingsTile(
        leading: Image.asset(AppAssets.deleteIcon, height: 43.h, width: 43.w),
        title: "Delete account",
        titleColor: Colors.red,
        trailing: const SizedBox(),
        onTap: () {
          Utils.showBottomSheet(
            context: context,
            child: DeleteAccountSheet(
              onDeleteTap: () async {
                Get.dialog(CustomLoader(), barrierDismissible: false);
                bool isLogout = await controller.deleteAccountApi();
                Get.back();
                if (isLogout) {
                  Get.offAllNamed(AppRoutes.userSelectionView);
                } else {}
              },
            ),
          );
        },
      ),
    ];

    // Animate each tile with stagger
    return tiles.asMap().entries.map((entry) {
      final index = entry.key;
      final tile = entry.value;
      return tile.animate().fadeIn(duration: 500.ms, delay: (index * 150).ms).slideX(begin: 0.1, end: 0);
    }).toList();
  }

  Widget _settingsTile({
    required Widget leading,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
    Color titleColor = Colors.black,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      leading: leading,
      title: Text(
        title,
        style: AppTextStyles.customText14(color: titleColor, fontWeight: FontWeight.w400),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
