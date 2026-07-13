import 'package:get/get.dart';
import 'package:shamba_ai/features/language_select/views/language_select_screen.dart';
import 'package:shamba_ai/features/splash/views/splash_screen.dart';
import 'package:shamba_ai/features/onboarding/views/onboarding_screen.dart';
import 'package:shamba_ai/features/auth/views/login_screen.dart';
import 'package:shamba_ai/features/auth/views/otp_verify_screen.dart';
import 'package:shamba_ai/features/home/views/home_screen.dart';
import 'package:shamba_ai/features/farm_profile/views/farm_profile_screen.dart';
import 'package:shamba_ai/features/farm_profile/views/farm_profile_setup_screen.dart';
import 'package:shamba_ai/features/crop_tracking/views/crop_tracking_screen.dart';
import 'package:shamba_ai/features/crop_tracking/views/crop_add_screen.dart';
import 'package:shamba_ai/features/crop_tracking/views/crop_detail_screen.dart';
import 'package:shamba_ai/features/notifications/views/notifications_screen.dart';
import 'package:shamba_ai/features/profile/views/profile_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.languageSelect,
      page: () => const LanguageSelectScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.otpVerify,
      page: () => const OtpVerifyScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.farmProfile,
      page: () => const FarmProfileScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.farmProfileSetup,
      page: () => const FarmProfileSetupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cropTracking,
      page: () => const CropTrackingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cropAdd,
      page: () => const CropAddScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.cropDetail,
      page: () => const CropDetailScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const ProfileScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
