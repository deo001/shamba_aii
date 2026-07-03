import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';

class CropDetailScreen extends StatelessWidget {
  const CropDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 16),
              GestureDetector(onTap: () => Get.back(), child: Container(width: 44, height: 44, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppColors.bgCard, border: const Border.fromBorderSide(BorderSide(color: AppColors.border))), child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18))),
              const SizedBox(height: 24),
              Text(l.cropHistory, style: AppTextStyles.headlineLarge),
              const SizedBox(height: 16),
              Text(l.growthStage, style: AppTextStyles.titleMedium),
            ]),
          ),
        ),
      ),
    );
  }
}
