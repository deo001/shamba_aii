// ignore_for_file: unused_import
import 'package:get/get.dart';
import 'package:shamba_ai/core/services/locale_service.dart';
import 'package:shamba_ai/core/services/storage_service.dart';
import 'package:shamba_ai/routes/app_routes.dart';

class LanguageSelectController extends GetxController {
  final selectedLanguage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Pre-select if already chosen before
    final saved = StorageService.getLanguage();
    if (saved != null) selectedLanguage.value = saved;
  }

  void selectLanguage(String lang) {
    selectedLanguage.value = lang;
  }

  Future<void> proceed() async {
    if (selectedLanguage.value.isEmpty) return;
    await LocaleService.changeLocale(selectedLanguage.value);
    // Navigate to splash for further routing
    Get.offAllNamed(AppRoutes.splash);
  }
}
