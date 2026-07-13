import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/services/firestore_service.dart';
import 'package:shamba_ai/core/services/storage_service.dart';
import 'package:shamba_ai/routes/app_routes.dart';

enum AuthMode { phone, email }

class AuthController extends GetxController {
  final phone = ''.obs;
  final countryCode = '+255'.obs;
  final email = ''.obs;
  final password = ''.obs;
  final authMode = AuthMode.phone.obs;
  final isRegistering = false.obs;
  final isLoading = false.obs;
  final verificationId = ''.obs;
  int? _forceResendingToken;

  // OTP countdown
  final resendSeconds = 60.obs;
  bool _timerRunning = false;

  void setPhone(String value) => phone.value = value;
  void setCountryCode(String code) => countryCode.value = code;
  void setEmail(String value) => email.value = value.trim();
  void setPassword(String value) => password.value = value;
  void setAuthMode(AuthMode mode) => authMode.value = mode;
  void toggleRegistering() => isRegistering.toggle();

  String get fullPhone {
    final normalizedPhone = phone.value.replaceAll(RegExp(r'\s+|-'), '');
    return '${countryCode.value}$normalizedPhone';
  }

  bool get isPhoneValid => phone.value.length >= 7;
  bool get isEmailValid => GetUtils.isEmail(email.value);
  bool get isPasswordValid => password.value.length >= 6;

  Future<void> signInWithEmailPassword() async {
    if (!isEmailValid || !isPasswordValid) {
      Get.snackbar(
        'Error',
        'Enter a valid email and a password of at least 6 characters',
      );
      return;
    }

    isLoading.value = true;
    try {
      final credential = isRegistering.value
          ? await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email.value,
              password: password.value,
            )
          : await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email.value,
              password: password.value,
            );

      final user = credential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'missing-user',
          message: 'Firebase did not return a signed-in user.',
        );
      }

      await _completeSignIn(user);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Authentication failed', _authErrorMessage(e));
    } catch (e) {
      Get.snackbar('Authentication failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp() async {
    if (!isPhoneValid) {
      Get.snackbar('Error', 'Please enter a valid phone number');
      return;
    }
    isLoading.value = true;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullPhone,
      timeout: const Duration(seconds: 60),
      forceResendingToken: _forceResendingToken,
      verificationCompleted: (credential) async {
        try {
          final userCredential = await FirebaseAuth.instance
              .signInWithCredential(credential);
          final user = userCredential.user;
          if (user != null) {
            await _completeSignIn(user);
          }
        } on FirebaseAuthException catch (e) {
          Get.snackbar('Phone verification failed', _authErrorMessage(e));
        } finally {
          isLoading.value = false;
        }
      },
      verificationFailed: (e) {
        isLoading.value = false;
        Get.snackbar('Phone verification failed', _authErrorMessage(e));
      },
      codeSent: (vId, resendToken) {
        verificationId.value = vId;
        _forceResendingToken = resendToken;
        isLoading.value = false;
        _startResendTimer();
        Get.toNamed(AppRoutes.otpVerify);
      },
      codeAutoRetrievalTimeout: (vId) {
        verificationId.value = vId;
      },
    );
  }

  Future<void> verifyOtp(String code) async {
    if (verificationId.value.isEmpty || code.length < 6) {
      Get.snackbar('Error', 'Enter the 6-digit verification code');
      return;
    }

    isLoading.value = true;
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: code,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'missing-user',
          message: 'Firebase did not return a signed-in user.',
        );
      }

      await _completeSignIn(user);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('OTP verification failed', _authErrorMessage(e));
    } catch (e) {
      Get.snackbar('OTP verification failed', e.toString());
    } finally {
      isLoading.value = false;
    }
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
    await FirebaseAuth.instance.signOut();
    await StorageService.clearUser();
    Get.offAllNamed(AppRoutes.languageSelect);
  }

  Future<void> _completeSignIn(User user) async {
    await FirestoreService.upsertCurrentUser(user);
    await StorageService.setLoggedIn(true);
    await StorageService.setUserId(user.uid);

    final userPhone = user.phoneNumber;
    if (userPhone != null && userPhone.isNotEmpty) {
      await StorageService.setPhone(userPhone);
    }

    Get.offAllNamed(AppRoutes.home);
  }

  String _authErrorMessage(FirebaseAuthException e) {
    final message = e.message ?? '';
    if (message.contains('region enabled') ||
        message.contains('SMS unable to be sent')) {
      return 'SMS is not enabled for this phone region yet. In Firebase Console, allow this country under Authentication > Settings > SMS region policy.';
    }
    if (e.code == 'operation-not-allowed') {
      return 'This sign-in method is not enabled for the Firebase project.';
    }
    return message.isNotEmpty ? message : e.code;
  }
}
