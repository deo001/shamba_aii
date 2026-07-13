import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AuthController());
    final l = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),

                // ── Header ─────────────────────────────────────────────
                _buildHeader(
                  l,
                ).animate().fadeIn(duration: 700.ms).slideY(begin: -0.2),

                const SizedBox(height: 48),

                Obx(
                  () => _AuthModeToggle(
                    ctrl: ctrl,
                    selectedMode: ctrl.authMode.value,
                  ),
                ).animate().fadeIn(delay: 150.ms, duration: 500.ms),

                const SizedBox(height: 28),

                // ── Phone field ────────────────────────────────────────
                Obx(
                      () => ctrl.authMode.value == AuthMode.phone
                          ? _PhoneField(ctrl: ctrl, l: l)
                          : _EmailFields(ctrl: ctrl),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideX(begin: -0.1),

                const SizedBox(height: 32),

                // ── Send OTP Button ────────────────────────────────────
                Obx(
                  () => _SendButton(
                    isLoading: ctrl.isLoading.value,
                    label: ctrl.authMode.value == AuthMode.phone
                        ? l.sendOtp
                        : (ctrl.isRegistering.value
                              ? 'Create account'
                              : 'Sign in'),
                    onTap: ctrl.authMode.value == AuthMode.phone
                        ? ctrl.sendOtp
                        : ctrl.signInWithEmailPassword,
                  ),
                ).animate().fadeIn(delay: 350.ms, duration: 600.ms),

                Obx(
                  () => ctrl.authMode.value == AuthMode.email
                      ? Center(
                          child: TextButton(
                            onPressed: ctrl.isLoading.value
                                ? null
                                : ctrl.toggleRegistering,
                            child: Text(
                              ctrl.isRegistering.value
                                  ? 'Already have an account? Sign in'
                                  : 'New here? Create an account',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 24),

                // ── Terms ──────────────────────────────────────────────
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      l.agreeToTerms,
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ).animate().fadeIn(delay: 500.ms, duration: 600.ms),

                const SizedBox(height: 40),

                // ── Decorative bottom pattern ──────────────────────────
                Center(
                  child: Opacity(
                    opacity: 0.08,
                    child: Text(
                      '🌾🌿🌱🌾🌿🌱',
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Small ShambaAI logo
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryLight.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text('🌾', style: TextStyle(fontSize: 28)),
          ),
        ),
        const SizedBox(height: 24),
        Text(l.welcomeBack, style: AppTextStyles.displayMedium),
        const SizedBox(height: 8),
        Text(l.enterPhone, style: AppTextStyles.bodyLarge),
      ],
    );
  }
}

class _AuthModeToggle extends StatelessWidget {
  final AuthController ctrl;
  final AuthMode selectedMode;
  const _AuthModeToggle({required this.ctrl, required this.selectedMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          _AuthModeButton(
            label: 'Phone',
            selected: selectedMode == AuthMode.phone,
            onTap: () => ctrl.setAuthMode(AuthMode.phone),
          ),
          _AuthModeButton(
            label: 'Email',
            selected: selectedMode == AuthMode.email,
            onTap: () => ctrl.setAuthMode(AuthMode.email),
          ),
        ],
      ),
    );
  }
}

class _AuthModeButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _AuthModeButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: selected ? AppColors.primaryGradient : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final AuthController ctrl;
  final AppLocalizations l;
  const _PhoneField({required this.ctrl, required this.l});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.phoneHint, style: AppTextStyles.labelLarge),
        const SizedBox(height: 10),
        IntlPhoneField(
          decoration: InputDecoration(
            hintText: '7XX XXX XXX',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textHint,
            ),
            filled: true,
            fillColor: AppColors.bgCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.borderFocus,
                width: 2,
              ),
            ),
            counterText: '',
          ),
          style: AppTextStyles.titleMedium,
          dropdownTextStyle: AppTextStyles.bodyMedium,
          dropdownIcon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.textSecondary,
          ),
          initialCountryCode: 'TZ',
          showCountryFlag: true,
          onChanged: (phone) {
            ctrl.setCountryCode(phone.countryCode);
            ctrl.setPhone(phone.number);
          },
          dropdownDecoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}

class _EmailFields extends StatelessWidget {
  final AuthController ctrl;
  const _EmailFields({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: AppTextStyles.labelLarge),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: ctrl.setEmail,
          style: AppTextStyles.titleMedium,
          decoration: _inputDecoration('farmer@example.com'),
        ),
        const SizedBox(height: 18),
        Text('Password', style: AppTextStyles.labelLarge),
        const SizedBox(height: 10),
        TextField(
          obscureText: true,
          onChanged: ctrl.setPassword,
          style: AppTextStyles.titleMedium,
          decoration: _inputDecoration('Minimum 6 characters'),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
      filled: true,
      fillColor: AppColors.bgCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.borderFocus, width: 2),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool isLoading;
  final String label;
  final VoidCallback onTap;
  const _SendButton({
    required this.isLoading,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  label,
                  style: AppTextStyles.labelLarge.copyWith(fontSize: 17),
                ),
        ),
      ),
    );
  }
}
