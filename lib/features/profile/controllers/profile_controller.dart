import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/services/firestore_service.dart';
import 'package:shamba_ai/core/services/locale_service.dart';
import 'package:shamba_ai/core/services/storage_service.dart';
import 'package:shamba_ai/routes/app_routes.dart';

class ProfileController extends GetxController {
  final displayName = ''.obs;
  final photoUrl = ''.obs;
  final languageCode = 'en'.obs;
  final isLoading = false.obs;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    final user = currentUser;
    displayName.value = user?.displayName ?? '';
    photoUrl.value = user?.photoURL ?? '';
    languageCode.value = StorageService.getLanguage() ?? 'en';
  }

  void setDisplayName(String value) => displayName.value = value;
  void setPhotoUrl(String value) => photoUrl.value = value;

  Future<void> setLanguage(String value) async {
    languageCode.value = value;
    await LocaleService.changeLocale(value);

    if (currentUser != null) {
      await _saveProfile(showSuccess: false);
    }
  }

  Future<void> saveProfile() => _saveProfile();

  Future<void> _saveProfile({bool showSuccess = true}) async {
    isLoading.value = true;
    try {
      await FirestoreService.updateCurrentUserProfile(
        displayName: displayName.value,
        photoUrl: photoUrl.value,
        languageCode: languageCode.value,
      );
      if (showSuccess) {
        Get.snackbar('Profile updated', 'Your profile changes were saved.');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Profile update failed', e.message ?? e.code);
    } catch (e) {
      Get.snackbar('Profile update failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.signOut();
      await StorageService.clearUser();
      Get.offAllNamed(AppRoutes.languageSelect);
    } finally {
      isLoading.value = false;
    }
  }
}
