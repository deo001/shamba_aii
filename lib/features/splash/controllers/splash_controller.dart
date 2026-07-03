import 'package:get/get.dart';
import 'package:shamba_ai/core/services/storage_service.dart';
import 'package:shamba_ai/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    // Hold splash for branding moment
    await Future.delayed(const Duration(milliseconds: 2200));

    if (StorageService.isLoggedIn()) {
      Get.offAllNamed(AppRoutes.home);
    } else if (StorageService.isOnboardingDone()) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
