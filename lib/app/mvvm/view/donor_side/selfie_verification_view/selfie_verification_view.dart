import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/auth_controllers/sign_up_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/app_text_style.dart';
import '../../../../config/global_variables.dart';
import '../../../../customWidgets/custom_loader.dart';
import '../../../../customWidgets/custom_snackbar/custom_snackbar.dart';

class SelfieVerificationView extends StatefulWidget {
  const SelfieVerificationView({super.key});

  @override
  State<SelfieVerificationView> createState() => _SelfieVerificationViewState();
}

class _SelfieVerificationViewState extends State<SelfieVerificationView> with WidgetsBindingObserver {
  final SignUpController authController = Get.find();
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isPermissionGranted = false;
  String? _errorMessage;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
      await _initializeCamera();
    } else {
      setState(() {
        _isPermissionGranted = false;
        _errorMessage = 'Camera permission is required for selfie verification';
      });
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        // Use front camera for selfie
        final frontCamera = _cameras!.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front, orElse: () => _cameras!.first);

        _cameraController = CameraController(frontCamera, ResolutionPreset.high, enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);

        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
            _errorMessage = null;
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize camera: ${e.toString()}';
      });
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController != null && _cameraController!.value.isInitialized && !_isCapturing) {
      try {
        setState(() {
          _isCapturing = true;
        });

        // Capture selfie
        final XFile image = await _cameraController!.takePicture();

        // ✅ Store directly in AuthController
        authController.profilePicture.value = File(image.path);

        if (mounted) {
          // ✅ Show success message
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Selfie captured successfully!'), backgroundColor: Colors.green, duration: Duration(seconds: 2)));

          // ✅ Call signup API
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

          // ✅ Optionally navigate next after success
          // Get.offAllNamed(AppRoutes.userSelectionView);
        }

        print('📸 Picture stored at: ${image.path}');
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error taking picture: ${e.toString()}'), backgroundColor: Colors.red));
        }
      } finally {
        setState(() {
          _isCapturing = false;
        });
      }
    }
  }

  Widget _buildCameraPreview() {
    if (!_isPermissionGranted) {
      return _buildPermissionDeniedView();
    }

    if (_errorMessage != null) {
      return _buildErrorView();
    }

    if (!_isCameraInitialized || _cameraController == null) {
      return _buildLoadingView();
    }

    return CameraPreview(_cameraController!);
  }

  Widget _buildPermissionDeniedView() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2C3E50), Color(0xFF34495E)]),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt_outlined, size: 64, color: Colors.white54),
            16.h.height,
            const Text(
              'Camera Permission Required',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            8.h.height,
            const Text(
              'Please grant camera permission to continue',
              style: TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            24.h.height,
            ElevatedButton(
              onPressed: _requestCameraPermission,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
              child: const Text('Grant Permission'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2C3E50), Color(0xFF34495E)]),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            16.h.height,
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            24.h.height,
            ElevatedButton(
              onPressed: _initializeCamera,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2C3E50), Color(0xFF34495E)]),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFFFFC107)),
            SizedBox(height: 16),
            Text('Initializing Camera...', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Camera preview background
          //Positioned.fill(child: _buildCameraPreview()),
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 160.h),
            decoration: BoxDecoration(
              //color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Stack(
                children: [
                  // Camera preview background
                  Positioned.fill(child: _buildCameraPreview()),

                  if (_isCameraInitialized && _isPermissionGranted && _errorMessage == null) Container(color: Colors.black.withOpacity(0.6)),

                  // Face outline overlay (only when camera is working)
                  if (_isCameraInitialized && _isPermissionGranted && _errorMessage == null) Positioned.fill(child: CustomPaint()),
                ],
              ),
            ),
          ),

          // Dark overlay for entire screen
          if (_isCameraInitialized && _isPermissionGranted && _errorMessage == null)
            // Positioned.fill(
            //
            //   child: Container(color: Colors.black.withOpacity(0.6)),
            // ),
            // Clear camera preview area (face cutout)
            if (_isCameraInitialized && _isPermissionGranted && _errorMessage == null)
              Positioned.fill(
                child: ClipPath(clipper: FaceAreaClipper(), child: _buildCameraPreview()),
              ),

          // Face outline border
          if (_isCameraInitialized && _isPermissionGranted && _errorMessage == null) Positioned.fill(child: CustomPaint(size: screenSize)),

          // Header section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(onTap: () => Get.back(), child: SvgPicture.asset(AppAssets.whiteBackButton)),
                  12.h.height,
                  Text(
                    'Selfie Verification',
                    style: AppTextStyles.customText24(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  4.h.height,
                  // Subtitle
                  Text(
                    'Complete the form and join Donate',
                    style: AppTextStyles.customText14(color: Colors.white, fontWeight: FontWeight.w400, height: 1),
                  ),
                ],
              ),
            ),
          ),

          // Bottom section with camera button and instructions
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _isCameraInitialized && _isPermissionGranted && !_isCapturing ? _takePicture : null,
                  child: SvgPicture.asset(AppAssets.cameraIcon),
                ),
                const SizedBox(height: 16),
                Text(
                  _isCameraInitialized && _isPermissionGranted
                      ? "Center your face to the screen and\npress the camera button"
                      : "Please allow camera access to continue",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FaceAreaClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Base size (from original SVG)
    final baseWidth = 375;
    final baseHeight = 709;

    final scaleX = (size.width / baseWidth) * 0.93; // Increased from 0.8 → wider
    final scaleY = (size.height / baseHeight) * 0.78; // Increased from 0.65 → taller

    final offsetX = (size.width - baseWidth * scaleX) / 2;
    final offsetY = size.height * 0.16; // small upward adjust

    final facePath = _buildFacePath(scaleX, scaleY, offsetX, offsetY);
    return facePath;
  }

  Path _buildFacePath(double scaleX, double scaleY, double offsetX, double offsetY) {
    final facePath = Path();

    final startX = 187.155 * scaleX + offsetX;
    final startY = 108.125 * scaleY + offsetY;

    facePath.moveTo(startX, startY);

    facePath.cubicTo(
      88.4546 * scaleX + offsetX,
      108.125 * scaleY + offsetY,
      39.1045 * scaleX + offsetX,
      181.953 * scaleY + offsetY,
      39.1045 * scaleX + offsetX,
      255.781 * scaleY + offsetY,
    );

    facePath.cubicTo(
      39.1045 * scaleX + offsetX,
      354.219 * scaleY + offsetY,
      113.13 * scaleX + offsetX,
      501.875 * scaleY + offsetY,
      187.155 * scaleX + offsetX,
      501.875 * scaleY + offsetY,
    );

    facePath.cubicTo(
      261.181 * scaleX + offsetX,
      501.875 * scaleY + offsetY,
      335.206 * scaleX + offsetX,
      354.219 * scaleY + offsetY,
      335.206 * scaleX + offsetX,
      255.781 * scaleY + offsetY,
    );

    facePath.cubicTo(
      335.206 * scaleX + offsetX,
      181.953 * scaleY + offsetY,
      285.856 * scaleX + offsetX,
      108.125 * scaleY + offsetY,
      187.155 * scaleX + offsetX,
      108.125 * scaleY + offsetY,
    );

    facePath.close();
    return facePath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
