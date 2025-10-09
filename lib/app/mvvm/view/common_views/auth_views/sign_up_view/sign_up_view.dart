import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/global_variables.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';

import '../../../../../config/app_assets.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../config/app_routes.dart';
import '../../../../../config/app_strings.dart';
import '../../../../../config/app_text_style.dart';
import '../../../../../config/utils.dart';
import '../../../../../customWidgets/app_custom_button.dart';
import '../../../../../customWidgets/app_custom_field.dart';
import '../../../../../customWidgets/custom_loader.dart';
import '../../../../../customWidgets/custom_snackbar/custom_snackbar.dart';
import '../../../../view_model/common_controllers/auth_controllers/sign_up_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController authController = Get.find();

  final _formKey = GlobalKey<FormState>(); // 👈 Added for form validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* --- Header Section --- */
          Padding(
            padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(AppAssets.whiteBackButton),
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.3, curve: Curves.easeOut),

                16.h.height,

                Text(
                  'Sign Up',
                  style: AppTextStyles.customText24(color: Colors.white, fontWeight: FontWeight.w600),
                ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: -0.2),

                4.h.height,

                Text(
                  'Complete the form and join Donate',
                  style: AppTextStyles.customText14(color: Colors.white, fontWeight: FontWeight.w400, height: 1),
                ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideY(begin: -0.1),
              ],
            ),
          ),

          16.h.height,

          /* --- Content --- */
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
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey, // 👈 wrap fields in Form
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (GlobalVariables.userType == UserType.donor)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment(0, 1.3),
                                children: [
                                  Obx(() {
                                    return Container(
                                          height: 110.sp,
                                          width: 110.sp,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.white,
                                            border: Border.all(color: AppColors.scaffoldBgColor, width: 2.sp),
                                            image: DecorationImage(
                                              image: authController.profilePicture.value == null
                                                  ? AssetImage(AppAssets.placeholderMan)
                                                  : FileImage(authController.profilePicture.value!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                        .animate()
                                        .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1), curve: Curves.easeOutBack, duration: 400.ms)
                                        .fadeIn(duration: 300.ms);
                                  }),

                                  GestureDetector(
                                    onTap: () {
                                      Utils.showPickImageOptionsDialog(
                                        context,
                                        onCameraTap: () async {
                                          Navigator.of(context).pop();
                                          await authController.pickImageFromCamera(file: authController.profilePicture);
                                        },
                                        onGalleryTap: () async {
                                          Navigator.of(context).pop();
                                          await authController.pickImageFromGallery(file: authController.profilePicture);
                                        },
                                      );
                                    },
                                    child: SvgPicture.asset(AppAssets.cameraIcon, height: 25.h),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (GlobalVariables.userType == UserType.donor) 30.h.height,
                        /* --- First & Last Name --- */
                        Row(
                          children: [
                            Expanded(
                              child: AppCustomField(
                                labelTitle: 'First Name',
                                hintText: 'Enter first name',
                                controller: authController.firstNameController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'First name is required';
                                  }
                                  return null;
                                },
                              ),
                            ).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideY(begin: 0.2),
                            15.w.width,
                            Expanded(
                              child: AppCustomField(
                                labelTitle: 'Last Name',
                                hintText: 'Enter last name',
                                controller: authController.lastNameController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Last name is required';
                                  }
                                  return null;
                                },
                              ),
                            ).animate().fadeIn(duration: 400.ms, delay: 300.ms).slideY(begin: 0.2),
                          ],
                        ),

                        20.h.height,

                        /// Email Field with validation
                        AppCustomField(
                          labelTitle: 'Email Address',
                          hintText: 'Enter your email',
                          controller: authController.emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            } else if (!GetUtils.isEmail(value.trim())) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ).animate().fadeIn(duration: 400.ms, delay: 400.ms).slideY(begin: 0.2),

                        20.h.height,

                        /// Password Field with validation
                        Obx(
                          () => AppCustomField(
                            labelTitle: 'Password',
                            hintText: 'Enter your password',
                            controller: authController.passwordController,
                            obscureText: authController.isVisible.value,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password is required';
                              } else if (value.trim().length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            suffixIcon: GestureDetector(
                              onTap: authController.togglePassword,
                              child: Icon(
                                authController.isVisible.value ? Icons.visibility_off : Icons.visibility,
                                size: 20.sp,
                                color: AppColors.textLightBlack,
                              ),
                            ).paddingLeft(25.w),
                          ).animate().fadeIn(duration: 400.ms, delay: 500.ms).slideY(begin: 0.2),
                        ),

                        20.h.height,

                        /// Confirm Password Field with validation
                        Obx(
                          () => AppCustomField(
                            labelTitle: 'Confirm Password',
                            hintText: 'Re-enter your password',
                            controller: authController.confirmPasswordController,
                            obscureText: authController.isConfirmPasswordVisible.value,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != authController.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            suffixIcon: GestureDetector(
                              onTap: authController.toggleConfirmPassword,
                              child: Icon(
                                authController.isConfirmPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                                size: 20.sp,
                                color: AppColors.textLightBlack,
                              ),
                            ).paddingLeft(25.w),
                          ).animate().fadeIn(duration: 400.ms, delay: 600.ms).slideY(begin: 0.2),
                        ),

                        30.h.height,

                        /* --- Sign Up Button --- */
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: AppCustomButton(
                            title: 'Sign Up',
                            bgColor: AppColors.secondary,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (GlobalVariables.userType == UserType.donor) {
                                  Get.dialog(CustomLoader(), barrierDismissible: false);
                                  bool isSignUp = await authController.signUp();
                                  Get.back();
                                  if (isSignUp) {
                                    CustomSnackbar.show(
                                      iconData: Icons.check_circle,
                                      title: "Success",
                                      message: "",
                                      textColor: AppColors.positiveGreen,
                                      backgroundColor: AppColors.white,
                                      iconColor: Colors.green,
                                      borderColor: AppColors.positiveGreen,
                                      messageText: ["User Registered Successfully. Now check your email for verification."],
                                    );
                                    Get.offAllNamed(AppRoutes.loginView);
                                  } else {
                                    CustomSnackbar.show(
                                      iconData: Icons.warning_amber,
                                      textColor: AppColors.negativeRed,
                                      title: "Error",
                                      message: "",
                                      backgroundColor: AppColors.white,
                                      iconColor: AppColors.negativeRed,
                                      borderColor: AppColors.negativeRed,
                                      messageText: GlobalVariables.errorMessages,
                                    );
                                  }
                                } else if (GlobalVariables.userType == UserType.needy) {
                                  Get.toNamed(AppRoutes.identityVerificationView);
                                }
                              }
                            },
                          ).animate().fadeIn(duration: 600.ms, delay: 700.ms).scale(begin: const Offset(0.9, 0.9)),
                        ),

                        30.h.height,

                        /* --- Divider Text --- */
                        Center(
                          child: Text(
                            'OR CONTINUE WITH',
                            style: AppTextStyles.customTextFigtree(color: const Color(0xffCDCDCD), fontWeight: FontWeight.w500, fontSize: 18),
                          ).animate().fadeIn(duration: 500.ms, delay: 800.ms),
                        ),

                        30.h.height,

                        /* --- Social Icons --- */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialIcon(AppAssets.googleLogo).animate().fadeIn(duration: 500.ms, delay: 900.ms).scale(begin: const Offset(0.8, 0.8)),
                            20.w.width,
                            _socialIcon(AppAssets.appleLogo).animate().fadeIn(duration: 500.ms, delay: 1000.ms).scale(begin: const Offset(0.8, 0.8)),
                          ],
                        ),

                        30.h.height,

                        /* --- Bottom Row --- */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?', style: AppTextStyles.customText14(color: Colors.black)),
                            5.w.width,
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Text(
                                'Sign In',
                                style: AppTextStyles.customText16(color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 500.ms, delay: 1100.ms).slideY(begin: 0.2),
                      ],
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 500.ms, delay: 150.ms).slideY(begin: 0.3, curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return Container(
      height: 48.h,
      width: 48.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(child: SvgPicture.asset(assetPath)),
    );
  }
}
