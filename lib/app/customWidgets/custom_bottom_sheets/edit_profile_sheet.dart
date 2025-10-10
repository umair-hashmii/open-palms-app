import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/app_assets.dart';
import 'package:open_palms/app/config/app_text_style.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/app_custom_field.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/auth_controllers/profile_controller.dart';
import '../../config/app_colors.dart';
import '../../config/global_variables.dart';
import '../app_custom_button.dart';
import '../custom_loader.dart';
import '../custom_snackbar/custom_snackbar.dart';

class EditProfileSheet extends StatefulWidget {
  const EditProfileSheet({super.key});

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  final ProfileController controller = Get.find();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              15.h.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(AppAssets.closeIcon),
                  ),
                ],
              ),
              Text(
                'Edit Profile',
                style: AppTextStyles.customText24(color: Color(0xff111827), fontWeight: FontWeight.bold),
              ),
              22.h.height,
              Row(
                children: [
                  Expanded(
                    child: AppCustomField(
                      labelTitle: 'First Name',
                      hintText: 'Enter first name',
                      isRequired: false,
                      controller: controller.firstNameController,
                    ),
                  ),
                  15.w.width,
                  Expanded(
                    child: AppCustomField(labelTitle: 'Last Name', hintText: 'Enter last name', isRequired: false, controller: controller.lastNameController),
                  ),
                ],
              ),

              20.h.height,
              /* --- Email --- */
              AppCustomField(
                labelTitle: 'Email Address',
                hintText: 'Enter your email',
                isRequired: false,
                isReadOnly: true,
                controller: controller.emailController,
              ),
              30.h.height,
              AppCustomButton(
                title: 'Update Profile',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Get.dialog(CustomLoader(), barrierDismissible: false);
                    bool isLogin = await controller.updateProfileApi();
                    Get.back();
                    if (isLogin) {
                      Get.back();
                      CustomSnackbar.show(
                        iconData: Icons.check_circle,
                        title: "Success",
                        message: "",
                        textColor: AppColors.positiveGreen,
                        backgroundColor: AppColors.white,
                        iconColor: Colors.green,
                        borderColor: AppColors.positiveGreen,
                        messageText: ["Profile Updated"],
                      );
                      controller.fetchUserData();
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
              ).paddingHorizontal(50.w),
              10.h.height,
            ],
          ).paddingHorizontal(15.w),
        ),
      ),
    );
  }
}
