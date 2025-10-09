import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/config/utils.dart';
import 'package:open_palms/app/customWidgets/app_custom_button.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/auth_controllers/sign_up_controller.dart';

import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/app_text_style.dart';
import '../../../../customWidgets/custom_snackbar/custom_snackbar.dart';

class IdentityVerifyView extends StatefulWidget {
  const IdentityVerifyView({super.key});

  @override
  State<IdentityVerifyView> createState() => _IdentityVerifyViewState();
}

class _IdentityVerifyViewState extends State<IdentityVerifyView> {
  final SignUpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Top Section ---
          Padding(
            padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(AppAssets.whiteBackButton),
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, curve: Curves.easeOut),

                16.h.height,

                Text(
                  'Identity Verification',
                  style: AppTextStyles.customText24(color: Colors.white, fontWeight: FontWeight.w600),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3, curve: Curves.easeOut),

                4.h.height,

                Text(
                  'Complete the form and join Donate',
                  style: AppTextStyles.customText14(color: Colors.white, fontWeight: FontWeight.w400, height: 1),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),
              ],
            ),
          ),

          20.h.height,

          /// --- Main Content ---
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14.r), topRight: Radius.circular(14.r)),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      /// ID Selection Tiles
                      _buildAnimatedTile(
                        Obx(() {
                          return GestureDetector(
                            onTap: () => controller.imageType.value = 'national',
                            child: _buildTile(AppAssets.idIcon, "National ID", AppAssets.tickIcon, isVerified: controller.imageType.value == 'national'),
                          );
                        }),
                        delay: 200,
                      ),

                      _divider(),

                      _buildAnimatedTile(
                        Obx(() {
                          return GestureDetector(
                            onTap: () => controller.imageType.value = 'passport',
                            child: _buildTile(AppAssets.passportIcon, "Passport", AppAssets.tickIcon, isVerified: controller.imageType.value == 'passport'),
                          );
                        }),
                        delay: 300,
                      ),

                      _divider(),

                      _buildAnimatedTile(
                        Obx(() {
                          return GestureDetector(
                            onTap: () => controller.imageType.value = 'license',
                            child: _buildTile(AppAssets.licenseIcon, "License", AppAssets.tickIcon, isVerified: controller.imageType.value == 'license'),
                          );
                        }),
                        delay: 400,
                      ),

                      _divider(),

                      /// Conditional Upload Sections
                      Obx(() {
                        if (controller.imageType.value == 'national') {
                          return Column(
                            children: [
                              _animateUploadSection(
                                controller.nationalIdFront.value,
                                "Front Side",
                                () => controller.nationalIdFront.value = null,
                                onPick: () {
                                  Utils.showPickImageOptionsDialog(
                                    context,
                                    onCameraTap: () {
                                      Get.back();
                                      controller.pickImageFromCamera(file: controller.nationalIdFront);
                                    },
                                    onGalleryTap: () {
                                      Get.back();
                                      controller.pickImageFromGallery(file: controller.nationalIdFront);
                                    },
                                  );
                                },
                                delay: 500,
                              ),
                              _animateUploadSection(
                                controller.nationalIdBack.value,
                                "Back Side",
                                () => controller.nationalIdBack.value = null,
                                onPick: () {
                                  Utils.showPickImageOptionsDialog(
                                    context,
                                    onCameraTap: () {
                                      Get.back();
                                      controller.pickImageFromCamera(file: controller.nationalIdBack);
                                    },
                                    onGalleryTap: () {
                                      Get.back();
                                      controller.pickImageFromGallery(file: controller.nationalIdBack);
                                    },
                                  );
                                },
                                delay: 600,
                              ),
                            ],
                          ).paddingTop(10.h);
                        } else if (controller.imageType.value == 'passport') {
                          return _animateUploadSection(
                            controller.passportImage.value,
                            "Passport",
                            () => controller.passportImage.value = null,
                            onPick: () {
                              Utils.showPickImageOptionsDialog(
                                context,
                                onCameraTap: () {
                                  Get.back();
                                  controller.pickImageFromCamera(file: controller.passportImage);
                                },
                                onGalleryTap: () {
                                  Get.back();
                                  controller.pickImageFromGallery(file: controller.passportImage);
                                },
                              );
                            },
                            delay: 500,
                          ).paddingTop(10.h);
                        } else if (controller.imageType.value == 'license') {
                          return _animateUploadSection(
                            controller.licenseImage.value,
                            "License",
                            () => controller.licenseImage.value = null,
                            onPick: () {
                              Utils.showPickImageOptionsDialog(
                                context,
                                onCameraTap: () {
                                  Get.back();
                                  controller.pickImageFromCamera(file: controller.licenseImage);
                                },
                                onGalleryTap: () {
                                  Get.back();
                                  controller.pickImageFromGallery(file: controller.licenseImage);
                                },
                              );
                            },
                            delay: 500,
                          ).paddingTop(10.h);
                        }
                        return const SizedBox.shrink();
                      }),

                      20.h.height,

                      /// Next Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                        child: AppCustomButton(
                          title: "Next",
                          bgColor: AppColors.secondary,
                          onPressed: () {
                            final type = controller.imageType.value;

                            if (type.isEmpty) {
                              CustomSnackbar.show(
                                iconData: Icons.warning_amber,
                                textColor: AppColors.negativeRed,
                                title: "Error",
                                message: "",
                                backgroundColor: AppColors.white,
                                iconColor: AppColors.negativeRed,
                                borderColor: AppColors.negativeRed,
                                messageText: ["Please select an identity document type."],
                              );
                              return;
                            }

                            if (type == 'national') {
                              if (controller.nationalIdFront.value == null || controller.nationalIdBack.value == null) {
                                CustomSnackbar.show(
                                  iconData: Icons.warning_amber,
                                  textColor: AppColors.negativeRed,
                                  title: "Error",
                                  message: "",
                                  backgroundColor: AppColors.white,
                                  iconColor: AppColors.negativeRed,
                                  borderColor: AppColors.negativeRed,
                                  messageText: ["Please upload both front and back images of your National ID."],
                                );
                                return;
                              }
                            } else if (type == 'passport') {
                              if (controller.passportImage.value == null) {
                                CustomSnackbar.show(
                                  iconData: Icons.warning_amber,
                                  textColor: AppColors.negativeRed,
                                  title: "Error",
                                  message: "",
                                  backgroundColor: AppColors.white,
                                  iconColor: AppColors.negativeRed,
                                  borderColor: AppColors.negativeRed,
                                  messageText: ["Please upload your Passport image."],
                                );
                                return;
                              }
                            } else if (type == 'license') {
                              if (controller.licenseImage.value == null) {
                                CustomSnackbar.show(
                                  iconData: Icons.warning_amber,
                                  textColor: AppColors.negativeRed,
                                  title: "Error",
                                  message: "",
                                  backgroundColor: AppColors.white,
                                  iconColor: AppColors.negativeRed,
                                  borderColor: AppColors.negativeRed,
                                  messageText: ["Please upload your License image."],
                                );
                                return;
                              }
                            }
                            controller.getIdentityImagesList();
                            // ✅ All validations passed
                            Get.toNamed(AppRoutes.selfieVerificationView);
                          },
                        ).animate().fadeIn(duration: 700.ms).scale(begin: const Offset(0.9, 0.9)),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 10.w),
                ),
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }

  /// Animated wrapper for tiles
  Widget _buildAnimatedTile(Widget child, {int delay = 0}) {
    return child.animate().fadeIn(duration: 500.ms, delay: delay.ms).slideX(begin: 0.2, curve: Curves.easeOut);
  }

  /// Divider
  Widget _divider() {
    return SizedBox(
      width: double.infinity,
      child: SvgPicture.asset(AppAssets.settingTileDivider, fit: BoxFit.fill, height: 1.5),
    ).animate().fadeIn(duration: 400.ms);
  }

  /// Animated upload section
  Widget _animateUploadSection(File? file, String title, VoidCallback onCrossTap, {required VoidCallback onPick, int delay = 0}) {
    if (file == null) {
      return GestureDetector(
        onTap: onPick,
        child: _buildDocument(title),
      ).animate().fadeIn(duration: 500.ms, delay: delay.ms).slideY(begin: 0.2, curve: Curves.easeOut);
    } else {
      return _buildImage(
        title: title,
        file: file,
        onCrossTap: onCrossTap,
      ).animate().fadeIn(duration: 500.ms, delay: delay.ms).slideY(begin: 0.2, curve: Curves.easeOut);
    }
  }

  /// Tile widget
  Widget _buildTile(String icon, String title, String desc, {bool isVerified = false}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: ListTile(
        leading: Image.asset(icon, width: 24.w, height: 24.h),
        title: Text(
          title,
          style: AppTextStyles.customText12(color: AppColors.black, fontWeight: FontWeight.w400),
        ),
        trailing: Image.asset(desc, width: 16.w, height: 16.h, color: isVerified ? Colors.deepOrangeAccent : AppColors.darkGreyColor),
      ),
    );
  }

  /// Document placeholder
  Widget _buildDocument(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.customText(fontSize: 14.sp, color: AppColors.grey, fontWeight: FontWeight.w400),
        ),
        14.height,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 75.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
            border: Border.all(color: const Color(0xFFE5E5E5)),
          ),
          child: Center(
            child: Image.asset(AppAssets.placeholderIcon, width: 54.w, height: 54.h),
          ),
        ),
      ],
    );
  }

  /// Uploaded image preview
  Widget _buildImage({required String title, required File file, required VoidCallback onCrossTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.customText(fontSize: 14.sp, color: AppColors.grey, fontWeight: FontWeight.w400),
        ),
        14.height,
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
            border: Border.all(color: const Color(0xFFE5E5E5)),
            image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(onTap: onCrossTap, child: SvgPicture.asset(AppAssets.closeIcon)).paddingAll(10.sp),
          ),
        ),
      ],
    );
  }
}
