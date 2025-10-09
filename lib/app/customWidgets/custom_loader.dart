import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../config/app_assets.dart';
import '../config/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final double? height;
  final double? width;

  const CustomLoader({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppColors.primary));
    // return SizedBox(
    //   child: Center(
    //     child: Lottie.asset(AppAssets.loaderAnimation, height: height ?? 160.sp, width: width ?? 160.sp),
    //   ),
    // );
  }
}
