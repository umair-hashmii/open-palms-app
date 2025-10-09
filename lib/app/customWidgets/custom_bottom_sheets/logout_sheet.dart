import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/app_assets.dart';
import 'package:open_palms/app/config/app_routes.dart';
import 'package:open_palms/app/config/app_text_style.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import '../../config/app_colors.dart';
import '../app_custom_button.dart';

class LogoutSheet extends StatelessWidget {
  final VoidCallback? onLogoutTap;

  const LogoutSheet({super.key, this.onLogoutTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            'Logout',
            style: AppTextStyles.customText24(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          5.h.height,
          Align(
            alignment: Alignment.center,
            child: Text(
              'Are you sure you want\nto logout from this account?',
              textAlign: TextAlign.center,
              style: AppTextStyles.customText16(color: AppColors.secondary, fontWeight: FontWeight.w500),
            ),
          ),
          13.h.height,
          Divider(color: Color(0xffD5D9E2)).paddingHorizontal(10.w),
          13.h.height,

          AppCustomButton(title: 'Yes', onPressed: onLogoutTap ?? () {}).paddingHorizontal(50.w),
          15.h.height,
        ],
      ).paddingHorizontal(15.w),
    );
  }
}
