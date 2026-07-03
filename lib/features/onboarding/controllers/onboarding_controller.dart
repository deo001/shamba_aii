import 'package:get/get.dart';
import 'package:shamba_ai/core/services/storage_service.dart';
import 'package:shamba_ai/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final currentPage = 0.obs;

  static const int totalPages = 3;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    } else {
      finish();
    }
  }

  void skip() => finish();

  Future<void> finish() async {
    await StorageService.setOnboardingDone();
    Get.offAllNamed(AppRoutes.login);
  }

  bool get isLastPage => currentPage.value == totalPages - 1;
}
