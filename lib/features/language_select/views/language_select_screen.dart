import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import '../controllers/language_select_controller.dart';

class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(LanguageSelectController());

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // ── Logo ───────────────────────────────────────────────
                _Logo()
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: -0.3, curve: Curves.easeOutCubic),

                const SizedBox(height: 56),

                // ── Headline ───────────────────────────────────────────
                Text(
                  'Choose Your Language',
                  style: AppTextStyles.headlineLarge,
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideY(begin: 0.2),

                const SizedBox(height: 8),

                Text(
                  'Chagua Lugha Yako',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primaryLight,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 350.ms, duration: 600.ms),

                const SizedBox(height: 48),

                // ── Language Cards ─────────────────────────────────────
                Obx(() => Column(
                      children: [
                        _LanguageCard(
                          flag: '🇬🇧',
                          name: 'English',
                          subtitle: 'Continue in English',
                          code: 'en',
                          isSelected: ctrl.selectedLanguage.value == 'en',
                          onTap: () => ctrl.selectLanguage('en'),
                          delay: 500,
                        ),
                        const SizedBox(height: 16),
                        _LanguageCard(
                          flag: '🇹🇿',
                          name: 'Kiswahili',
                          subtitle: 'Endelea kwa Kiswahili',
                          code: 'sw',
                          isSelected: ctrl.selectedLanguage.value == 'sw',
                          onTap: () => ctrl.selectLanguage('sw'),
                          delay: 650,
                        ),
                      ],
                    )),

                const Spacer(),

                // ── Continue Button ────────────────────────────────────
                Obx(() {
                  final canContinue = ctrl.selectedLanguage.value.isNotEmpty;
                  return AnimatedOpacity(
                    opacity: canContinue ? 1.0 : 0.4,
                    duration: const Duration(milliseconds: 300),
                    child: _ContinueButton(
                      onTap: canContinue ? ctrl.proceed : null,
                    ),
                  );
                }).animate().fadeIn(delay: 800.ms, duration: 600.ms),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryLight.withOpacity(0.35),
                blurRadius: 30,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text('🌾', style: TextStyle(fontSize: 46)),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'ShambaAI',
          style: GoogleFonts.outfit(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Your AI Farm Co-Pilot',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryLight,
          ),
        ),
      ],
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String flag;
  final String name;
  final String subtitle;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;
  final int delay;

  const _LanguageCard({
    required this.flag,
    required this.name,
    required this.subtitle,
    required this.code,
    required this.isSelected,
    required this.onTap,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isSelected ? AppColors.cardGradient : null,
          color: isSelected ? null : AppColors.bgCard,
          border: Border.all(
            color: isSelected ? AppColors.primaryLight : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryLight.withOpacity(0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.titleMedium),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isSelected
                            ? AppColors.primaryLight
                            : AppColors.textHint,
                      )),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primaryLight : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primaryLight : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 600.ms)
        .slideX(begin: 0.15, curve: Curves.easeOutCubic);
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _ContinueButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: onTap != null
              ? AppColors.primaryGradient
              : const LinearGradient(colors: [
                  AppColors.bgCard,
                  AppColors.bgCard,
                ]),
          boxShadow: onTap != null
              ? [
                  BoxShadow(
                    color: AppColors.primaryLight.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            'Continue',
            style: AppTextStyles.labelLarge.copyWith(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
