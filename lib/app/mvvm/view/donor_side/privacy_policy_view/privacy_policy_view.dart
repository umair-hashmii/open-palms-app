import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/customWidgets/custom_app_bar.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_strings.dart';
import '../../../../config/app_text_style.dart';
import '../../../../customWidgets/custom_loader.dart';
import '../../../view_model/common_controllers/auth_controllers/profile_controller.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  final ProfileController controller = Get.find();

  @override
  void initState() {
    controller.fetchSettings('privacy_policy');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppStrings.privacyPolicyLabel, backgroundColor: Colors.transparent),
      body: Obx(() {
        return controller.isSettingsLoading.value
            ? Center(child: CustomLoader())
            : SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1
                      Text(
                        controller.settings?.content ?? 'N/A',
                        style: AppTextStyles.customText16(color: AppColors.black, fontWeight: FontWeight.w500, height: 1),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
