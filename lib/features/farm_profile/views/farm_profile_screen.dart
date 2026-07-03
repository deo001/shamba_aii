import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/routes/app_routes.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';

class FarmProfileScreen extends StatelessWidget {
  const FarmProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppColors.bgCard, border: const Border.fromBorderSide(BorderSide(color: AppColors.border))),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(l.farmProfile, style: AppTextStyles.titleLarge),
                ]),
                const SizedBox(height: 32),
                Center(
                  child: Column(children: [
                    const Text('🏡', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: 16),
                    Text('Set up your farm profile', style: AppTextStyles.headlineMedium, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text('Add your farm details to get personalized advice', style: AppTextStyles.bodyLarge, textAlign: TextAlign.center),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.farmProfileSetup),
                      child: Container(
                        width: double.infinity, height: 56,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: AppColors.primaryGradient),
                        child: Center(child: Text(l.saveProfile, style: AppTextStyles.labelLarge.copyWith(fontSize: 16))),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
