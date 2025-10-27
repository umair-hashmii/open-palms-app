import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/app_assets.dart';
import 'package:open_palms/app/config/app_text_style.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/app_custom_field.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import '../../config/app_colors.dart';
import '../../mvvm/view_model/donor_side_controllers/delete_account_controller/delete_account_controller.dart';
import '../app_custom_button.dart';

class DeleteAccountSheet extends StatefulWidget {
  final VoidCallback? onDeleteTap;

  const DeleteAccountSheet({super.key, this.onDeleteTap});

  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  final DeleteAccountController controller = Get.put(DeleteAccountController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
              'Delete Account',
              style: AppTextStyles.customText24(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            10.h.height,
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your account will be permanently\ndeleted. You no longer can access it.',
                textAlign: TextAlign.center,
                style: AppTextStyles.customText16(color: AppColors.secondary, fontWeight: FontWeight.w500),
              ),
            ),
            15.h.height,
            Obx(
              () => AppCustomField(
                labelTitle: 'Password',
                hintText: 'Enter your password',
                controller: controller.passwordController,
                obscureText: controller.isVisible.value,
                isRequired: false,
                suffixIcon: IconButton(
                  icon: Icon(controller.isVisible.value ? Icons.visibility_off : Icons.visibility),
                  color: AppColors.toggleColor,
                  onPressed: controller.togglePassword,
                ),
              ),
            ),
            20.h.height,
            AppCustomButton(title: 'Delete Account', onPressed: widget.onDeleteTap ?? () {}).paddingHorizontal(50.w),
            20.h.height,
          ],
        ).paddingHorizontal(15.w),
      ),
    );
  }
}
