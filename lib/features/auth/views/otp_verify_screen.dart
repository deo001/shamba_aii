import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';
import '../controllers/auth_controller.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    final l = AppLocalizations.of(context);
    String otpCode = '';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // ── Back button ────────────────────────────────────────
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.bgCard,
                      border: const Border.fromBorderSide(
                        BorderSide(color: AppColors.border),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textPrimary,
                      size: 18,
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms),

                const SizedBox(height: 36),

                // ── Header ─────────────────────────────────────────────
                Text(l.verifyOtp, style: AppTextStyles.displayMedium)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.2),
                const SizedBox(height: 8),
                Obx(() => Text(
                      '${l.otpSentTo(ctrl.fullPhone)}',
                      style: AppTextStyles.bodyLarge,
                    )).animate().fadeIn(delay: 150.ms, duration: 600.ms),

                const SizedBox(height: 48),

                // ── OTP Pin Input ──────────────────────────────────────
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (v) => otpCode = v,
                  onCompleted: (v) {
                    otpCode = v;
                    ctrl.verifyOtp(v);
                  },
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(14),
                    fieldHeight: 58,
                    fieldWidth: 48,
                    activeColor: AppColors.primaryLight,
                    inactiveColor: AppColors.border,
                    selectedColor: AppColors.borderFocus,
                    activeFillColor: AppColors.bgCard,
                    inactiveFillColor: AppColors.bgCard,
                    selectedFillColor: AppColors.bgCardAlt,
                  ),
                  enableActiveFill: true,
                  textStyle: AppTextStyles.headlineMedium,
                  animationType: AnimationType.scale,
                  animationDuration: const Duration(milliseconds: 200),
                ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

                const SizedBox(height: 32),

                // ── Verify Button ──────────────────────────────────────
                Obx(() => GestureDetector(
                      onTap: ctrl.isLoading.value
                          ? null
                          : () => ctrl.verifyOtp(otpCode),
                      child: Container(
                        width: double.infinity,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: AppColors.primaryGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryLight.withOpacity(0.3),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: ctrl.isLoading.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  l.confirm,
                                  style: AppTextStyles.labelLarge
                                      .copyWith(fontSize: 17),
                                ),
                        ),
                      ),
                    )).animate().fadeIn(delay: 450.ms, duration: 600.ms),

                const SizedBox(height: 28),

                // ── Resend ─────────────────────────────────────────────
                Center(
                  child: Obx(() => ctrl.canResend
                      ? TextButton(
                          onPressed: ctrl.sendOtp,
                          child: Text(
                            l.resendOtp,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.primaryLight,
                            ),
                          ),
                        )
                      : Text(
                          l.resendIn(ctrl.resendSeconds.value),
                          style: AppTextStyles.bodySmall,
                        )),
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
