import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: Stack(
          children: [
            // ── Background glow ──────────────────────────────────────
            Positioned(
              top: -100,
              left: -80,
              child: Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryDark.withOpacity(0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              right: -100,
              child: Container(
                width: 420,
                height: 420,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.25),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // ── Center content ───────────────────────────────────────
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo icon with glow
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryLight.withOpacity(0.45),
                          blurRadius: 50,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('🌾', style: TextStyle(fontSize: 58)),
                    ),
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1.0, 1.0),
                        curve: Curves.elasticOut,
                        duration: 900.ms,
                      )
                      .fadeIn(duration: 500.ms),

                  const SizedBox(height: 24),

                  // App name
                  Text(
                    'ShambaAI',
                    style: GoogleFonts.outfit(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -1,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 700.ms)
                      .slideY(begin: 0.3, curve: Curves.easeOutCubic),

                  const SizedBox(height: 8),

                  // Tagline
                  Text(
                    'Your AI Farm Co-Pilot',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primaryLight,
                      letterSpacing: 0.3,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 700.ms),
                ],
              ),
            ),

            // ── Bottom loading indicator ─────────────────────────────
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryLight.withOpacity(0.6),
                    strokeWidth: 2.5,
                  ),
                ),
              ).animate().fadeIn(delay: 900.ms, duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}
