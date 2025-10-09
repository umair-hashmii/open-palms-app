import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/app_assets.dart';
import 'package:open_palms/app/config/app_strings.dart';
import 'package:open_palms/app/config/global_variables.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/app_custom_button.dart';
import 'package:open_palms/app/customWidgets/app_custom_field.dart';
import 'package:open_palms/app/customWidgets/custom_loader.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_routes.dart';
import '../../../../../config/app_text_style.dart';
import '../../../../../customWidgets/custom_snackbar/custom_snackbar.dart';
import '../../../../view_model/common_controllers/auth_controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController authController = Get.find();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          /// Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(onTap: () => Get.back(), child: SvgPicture.asset(AppAssets.whiteBackButton)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style: AppTextStyles.customText28(color: const Color(0xFF94E941), fontWeight: FontWeight.bold, height: 1),
                  ),
                  4.height,
                  Text(
                    "To OpenPalms",
                    style: AppTextStyles.customText28(color: Colors.white, fontWeight: FontWeight.w700, height: 1),
                  ),
                  6.height,
                  Text(
                    "Your Help, Their Hope.",
                    style: AppTextStyles.customText14(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400),
                  ),
                ],
              ).paddingTop(10.h),
              SvgPicture.asset(AppAssets.whiteBackButton, color: Colors.transparent),
            ],
          ).paddingTop(50.h).paddingHorizontal(15.w).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0, curve: Curves.easeOut),

          20.h.height,

          /// White rounded container
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14.r), topRight: Radius.circular(14.r)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        GlobalVariables.userType == UserType.donor ? AppStrings.wantToDonateLabel : "I Want Help",
                        style: AppTextStyles.customText28(color: Colors.black, fontWeight: FontWeight.bold),
                      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, curve: Curves.easeOut),

                      3.height,
                      Text(
                        "Make a difference by supporting verified\nrecipients in need",
                        style: AppTextStyles.customText14(color: const Color(0xff979797), fontWeight: FontWeight.w400),
                      ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideX(begin: 0.2, curve: Curves.easeOut),

                      30.height,

                      /// Email Field
                      AppCustomField(
                        labelTitle: "Email Address",
                        labelColor: AppColors.textColorBlackLight,
                        hintText: "Enter your email",
                        controller: authController.emailController,
                        isRequired: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email is required";
                          } else if (!GetUtils.isEmail(value.trim())) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ).animate(delay: 400.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeOut),

                      20.height,

                      /// Password Field
                      Obx(
                        () => AppCustomField(
                          labelTitle: "Password",
                          hintText: "Enter your password",
                          controller: authController.passwordController,
                          obscureText: authController.isVisible.value,
                          isRequired: false,
                          suffixIcon: GestureDetector(
                            onTap: authController.togglePassword,
                            child: Icon(authController.isVisible.value ? Icons.visibility_off : Icons.visibility, size: 20.sp, color: AppColors.textLightBlack),
                          ).paddingLeft(25.w),
                        ),
                      ).animate(delay: 600.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeOut),

                      14.height,

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.forgotPasswordView);
                          },
                          child: Text("Forgot Password?", style: AppTextStyles.customText14(color: Colors.black)),
                        ),
                      ).animate(delay: 700.ms).fadeIn(duration: 500.ms),

                      32.height,

                      /// Sign In Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: AppCustomButton(
                          title: "Sign In",
                          bgColor: AppColors.secondary,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              Get.dialog(CustomLoader(), barrierDismissible: false);
                              bool isLogin = await authController.login();
                              Get.back();
                              if (isLogin) {
                                CustomSnackbar.show(
                                  iconData: Icons.check_circle,
                                  title: "Success",
                                  message: "",
                                  textColor: AppColors.positiveGreen,
                                  backgroundColor: AppColors.white,
                                  iconColor: Colors.green,
                                  borderColor: AppColors.positiveGreen,
                                  messageText: ["User logged in Successfully"],
                                );
                                if (GlobalVariables.userType == UserType.donor) {
                                  Get.offAllNamed(AppRoutes.donorBottomBarView);
                                } else {
                                  Get.offAllNamed(AppRoutes.needyHomeView);
                                }
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
                            }
                          },
                        ),
                      ).animate(delay: 900.ms).fadeIn(duration: 500.ms).scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack),

                      32.h.height,

                      /// Or Continue With
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "OR CONTINUE WITH",
                            style: AppTextStyles.customTextFigtree(color: const Color(0xffCDCDCD), fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ],
                      ).animate(delay: 1100.ms).fadeIn(duration: 500.ms),

                      32.h.height,

                      /// Social Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_socialIcon(AppAssets.googleLogo), 20.width, _socialIcon(AppAssets.appleLogo)],
                      ).animate(delay: 1300.ms).fadeIn(duration: 500.ms).scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack),

                      30.h.height,

                      /// Bottom Sign Up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Don’t have an account?", style: AppTextStyles.customText14(color: Colors.black)),
                          5.width,
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.signUpView);
                            },
                            child: Text(
                              "Sign Up",
                              style: AppTextStyles.customText16(color: AppColors.primary, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ).animate(delay: 1500.ms).fadeIn(duration: 600.ms).slideY(begin: 0.2, curve: Curves.easeOut),
                    ],
                  ),
                ),
              ).paddingHorizontal(15.w).paddingTop(20.h),
            ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
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
