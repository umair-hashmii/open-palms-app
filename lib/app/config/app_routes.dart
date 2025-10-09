import 'package:get/get.dart';
import 'package:open_palms/app/mvvm/view/common_views/auth_views/forgot_password_view/forgot_password_view.dart';
import 'package:open_palms/app/mvvm/view/common_views/auth_views/login_view/login_view.dart';
import 'package:open_palms/app/mvvm/view/common_views/auth_views/otp_verification_view/otp_verification_view.dart';
import 'package:open_palms/app/mvvm/view/common_views/auth_views/set_password_view/set_password_view.dart';
import 'package:open_palms/app/mvvm/view/common_views/auth_views/sign_up_view/sign_up_view.dart';
import 'package:open_palms/app/mvvm/view/common_views/get_started_view/get_started_view.dart';
import 'package:open_palms/app/mvvm/view/common_views/notifications_view/notifications_view.dart';
import 'package:open_palms/app/mvvm/view/common_views/user_selection_view/user_selection_view.dart';
import 'package:open_palms/app/mvvm/view/donor_side/about_us_view/about_us_view.dart';
import 'package:open_palms/app/mvvm/view/donor_side/donor_bottom_bar_view/donor_bottom_bar_view.dart';
import 'package:open_palms/app/mvvm/view/donor_side/donor_bottom_bar_view/donor_profile_view.dart';
import 'package:open_palms/app/mvvm/view/donor_side/donor_request_detail_view/donor_request_detail_view.dart';
import 'package:open_palms/app/mvvm/view/donor_side/privacy_policy_view/privacy_policy_view.dart';
import 'package:open_palms/app/mvvm/view/donor_side/selfie_verification_view/selfie_verification_view.dart';
import 'package:open_palms/app/mvvm/view/need_people_side/create_request_view/create_request_view.dart';
import 'package:open_palms/app/mvvm/view/need_people_side/need_people_home_view/need_people_home_view.dart';
import 'package:open_palms/app/mvvm/view/need_people_side/needy_request_detail_view/needy_request_detail_view.dart';
import 'package:open_palms/app/mvvm/view/need_people_side/needy_request_history_view/needy_request_history_view.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/auth_controllers/forgot_password_controller.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/auth_controllers/login_controller.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/auth_controllers/profile_controller.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/auth_controllers/sign_up_controller.dart';
import 'package:open_palms/app/mvvm/view_model/common_controllers/splash_controller/splash_controller.dart';
import 'package:open_palms/app/mvvm/view_model/donor_side_controllers/donor_home_controller/donor_home_controller.dart';
import 'package:open_palms/app/mvvm/view_model/donor_side_controllers/donor_request_detail_controller.dart';
import 'package:open_palms/app/mvvm/view_model/needy_side_controllers/create_request_controller.dart';
import 'package:open_palms/app/mvvm/view_model/needy_side_controllers/needy_request_detail_controller.dart';

import '../mvvm/view/common_views/splash_view/splash_view.dart';
import '../mvvm/view/donor_side/identity_verification_view/identity_verification_view.dart';
import '../mvvm/view/donor_side/subscription_view/subscription_view.dart';
import '../mvvm/view_model/common_controllers/bottom_bar_controller/bottom_bar_controller.dart';

/// Defines navigation routes for the LayerX app.
abstract class AppRoutes {
  AppRoutes._();

  static const splashView = '/splashView';
  static const getStartedView = '/getStartedView';
  static const userSelectionView = '/userSelectionView';
  static const donorBottomBarView = '/donorBottomBarView';
  static const loginView = '/loginView';
  static const signUpView = '/signUpView';
  static const donorRequestDetailView = '/donorRequestDetailView';
  static const forgotPasswordView = '/forgotPasswordView';
  static const otpVerificationView = '/otpVerificationView';
  static const setPasswordView = '/setPasswordView';
  static const notificationsView = '/notificationsView';
  static const aboutUsView = '/aboutUsView';
  static const privacyPolicyView = '/privacyPolicyView';
  static const subscriptionView = '/subscriptionView';
  static const identityVerificationView = '/identityVerificationView';
  static const selfieVerificationView = '/selfieVerificationView';
  static const needyHomeView = '/needyHomeView';
  static const needyRequestDetailView = '/needyRequestDetailView';
  static const needyRequestHistoryView = '/needyRequestHistoryView';
  static const donorProfileView = '/donorProfileView';
  static const createRequestView = '/createRequestView';
}

abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splashView,
      page: () => SplashView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.getStartedView,
      page: () => GetStartedView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.userSelectionView,
      page: () => UserSelectionView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.loginView,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.signUpView,
      page: () => SignUpView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignUpController>(() => SignUpController());
      }),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordView,
      page: () => ForgotPasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
      }),
    ),
    GetPage(
      name: AppRoutes.otpVerificationView,
      page: () => OtpVerificationView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.setPasswordView,
      page: () => SetPasswordView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.donorRequestDetailView,
      page: () => DonorRequestDetailView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DonorRequestDetailController>(() => DonorRequestDetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.aboutUsView,
      page: () => AboutUsView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.privacyPolicyView,
      page: () => PrivacyPolicyView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.subscriptionView,
      page: () => SubscriptionView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.notificationsView,
      page: () => NotificationsView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<DonorRequestDetailController>(() => DonorRequestDetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.identityVerificationView,
      page: () => IdentityVerifyView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignUpController>(() => SignUpController());
      }),
    ),
    GetPage(
      name: AppRoutes.selfieVerificationView,
      page: () => SelfieVerificationView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignUpController>(() => SignUpController());
      }),
    ),
    GetPage(
      name: AppRoutes.donorBottomBarView,
      page: () => DonorBottomBarView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<BottomBarController>(() => BottomBarController());
        Get.lazyPut<DonorHomeController>(() => DonorHomeController());
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
    ),
    GetPage(
      name: AppRoutes.needyHomeView,
      page: () => NeedPeopleHomeView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<BottomBarController>(() => BottomBarController());
      }),
    ),
    GetPage(
      name: AppRoutes.needyRequestDetailView,
      page: () => NeedyRequestDetailView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NeedyRequestDetailController>(() => NeedyRequestDetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.needyRequestHistoryView,
      page: () => NeedyRequestHistoryView(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<NeedyRequestDetailController>(() => NeedyRequestDetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.donorProfileView,
      page: () => DonorProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
    ),
    GetPage(
      name: AppRoutes.createRequestView,
      page: () => CreateRequestView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CreateRequestController>(() => CreateRequestController());
      }),
    ),
  ];
}
