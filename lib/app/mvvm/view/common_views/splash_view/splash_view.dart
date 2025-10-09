import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/app_assets.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/splash_controller/splash_controller.dart';

import '../../../../config/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController controller = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      controller.checkUserData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🌟 Main Logo Animation
          Center(
            child: Image.asset(AppAssets.splashLogo, height: 300.h)
                .animate()
                .fadeIn(duration: 1000.ms, curve: Curves.easeInOut)
                .scale(begin: const Offset(0.6, 0.6), end: const Offset(1.0, 1.0), duration: 900.ms, curve: Curves.easeOutBack)
                .then(delay: 400.ms)
                .shake(duration: 800.ms, hz: 2, curve: Curves.easeInOut),
          ),

          // 🌟 Bottom SVG Logo Animation
          SvgPicture.asset(AppAssets.openPalmsLogo, height: 70.h)
              .paddingBottom(110.h)
              .animate()
              .fadeIn(duration: 1200.ms, delay: 800.ms, curve: Curves.easeIn)
              .slide(
                begin: const Offset(0, 0.5), // slide up from bottom
                end: Offset.zero,
                duration: 800.ms,
                curve: Curves.easeOut,
              ),
        ],
      ),
    );
  }
}
