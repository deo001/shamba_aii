import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageCtrl = PageController();
  final _ctrl = Get.put(OnboardingController());

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    final slides = [
      _OnboardSlide(
        emoji: '🔬',
        gradientStart: const Color(0xFF1B7A3E),
        gradientEnd: const Color(0xFF0F5229),
        title: l.onboardTitle1,
        desc: l.onboardDesc1,
        accentColor: AppColors.primaryLight,
      ),
      _OnboardSlide(
        emoji: '📊',
        gradientStart: const Color(0xFF1A5C7A),
        gradientEnd: const Color(0xFF0A3347),
        title: l.onboardTitle2,
        desc: l.onboardDesc2,
        accentColor: const Color(0xFF29B6F6),
      ),
      _OnboardSlide(
        emoji: '🤖',
        gradientStart: const Color(0xFF6B3FA0),
        gradientEnd: const Color(0xFF3B1F5C),
        title: l.onboardTitle3,
        desc: l.onboardDesc3,
        accentColor: const Color(0xFFCE93D8),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              // ── Skip button ──────────────────────────────────────────
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 12),
                  child: Obx(() => _ctrl.isLastPage
                      ? const SizedBox.shrink()
                      : TextButton(
                          onPressed: _ctrl.skip,
                          child: Text(
                            l.skip,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        )),
                ),
              ),

              // ── Pages ────────────────────────────────────────────────
              Expanded(
                child: PageView.builder(
                  controller: _pageCtrl,
                  itemCount: slides.length,
                  onPageChanged: (i) {
                    _ctrl.onPageChanged(i);
                  },
                  itemBuilder: (ctx, i) => slides[i],
                ),
              ),

              // ── Indicator + Button ───────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                child: Column(
                  children: [
                    SmoothPageIndicator(
                      controller: _pageCtrl,
                      count: slides.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 4,
                        activeDotColor: AppColors.primaryLight,
                        dotColor: AppColors.border,
                        spacing: 6,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Obx(() => _PrimaryButton(
                          label: _ctrl.isLastPage ? l.getStarted : l.next,
                          onTap: () {
                            if (_ctrl.isLastPage) {
                              _ctrl.finish();
                            } else {
                              _pageCtrl.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOutCubic,
                              );
                            }
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardSlide extends StatelessWidget {
  final String emoji;
  final String title;
  final String desc;
  final Color gradientStart;
  final Color gradientEnd;
  final Color accentColor;

  const _OnboardSlide({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.gradientStart,
    required this.gradientEnd,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration circle
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  gradientStart.withOpacity(0.4),
                  gradientEnd.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [gradientStart, gradientEnd],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gradientStart.withOpacity(0.35),
                      blurRadius: 40,
                      spreadRadius: 4,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 60)),
                ),
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: 0,
                end: -10,
                duration: 2500.ms,
                curve: Curves.easeInOut,
              ),

          const SizedBox(height: 48),

          Text(
            title,
            style: AppTextStyles.displayMedium,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),

          const SizedBox(height: 16),

          Text(
            desc,
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 150.ms, duration: 500.ms),

          const SizedBox(height: 12),

          // Colored accent line
          Container(
            width: 48,
            height: 3,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ).animate().fadeIn(delay: 300.ms).scaleX(),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: AppColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryLight.withOpacity(0.32),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(label, style: AppTextStyles.labelLarge.copyWith(fontSize: 17)),
        ),
      ),
    );
  }
}
