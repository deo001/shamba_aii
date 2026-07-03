import 'package:get/get.dart';
import 'package:shamba_ai/core/services/storage_service.dart';
import 'package:shamba_ai/routes/app_routes.dart';

class AuthController extends GetxController {
  final phone = ''.obs;
  final countryCode = '+254'.obs; // Kenya default
  final isLoading = false.obs;
  final verificationId = ''.obs;

  // OTP countdown
  final resendSeconds = 60.obs;
  bool _timerRunning = false;

  void setPhone(String value) => phone.value = value;
  void setCountryCode(String code) => countryCode.value = code;

  String get fullPhone => '${countryCode.value}${phone.value}';

  bool get isPhoneValid => phone.value.length >= 7;

  Future<void> sendOtp() async {
    if (!isPhoneValid) {
      Get.snackbar('Error', 'Please enter a valid phone number');
      return;
    }
    isLoading.value = true;

    // TODO: Wire Firebase Auth phone verification here
    // FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: fullPhone,
    //   verificationCompleted: ...,
    //   verificationFailed: ...,
    //   codeSent: (vId, _) { verificationId.value = vId; },
    //   codeAutoRetrievalTimeout: ...,
    // );

    // Simulated success for development
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    _startResendTimer();
    Get.toNamed(AppRoutes.otpVerify);
  }

  Future<void> verifyOtp(String code) async {
    isLoading.value = true;

    // TODO: Wire Firebase credential sign-in
    // final credential = PhoneAuthProvider.credential(
    //   verificationId: verificationId.value,
    //   smsCode: code,
    // );
    // await FirebaseAuth.instance.signInWithCredential(credential);

    // Simulated success for development
    await Future.delayed(const Duration(seconds: 1));
    await StorageService.setLoggedIn(true);
    await StorageService.setPhone(fullPhone);
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }

  void _startResendTimer() {
    if (_timerRunning) return;
    _timerRunning = true;
    resendSeconds.value = 60;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      resendSeconds.value--;
      if (resendSeconds.value <= 0) {
        _timerRunning = false;
        return false;
      }
      return true;
    });
  }

  bool get canResend => resendSeconds.value <= 0;

  Future<void> signOut() async {
    await StorageService.clearUser();
    Get.offAllNamed(AppRoutes.languageSelect);
  }
}
