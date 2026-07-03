import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/routes/app_routes.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';

class CropTrackingScreen extends StatelessWidget {
  const CropTrackingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(children: [
                GestureDetector(onTap: () => Get.back(), child: Container(width: 44, height: 44, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppColors.bgCard, border: const Border.fromBorderSide(BorderSide(color: AppColors.border))), child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18))),
                const SizedBox(width: 14),
                Expanded(child: Text(l.myCropsList, style: AppTextStyles.titleLarge)),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.cropAdd),
                  child: Container(width: 44, height: 44, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), gradient: AppColors.primaryGradient), child: const Icon(Icons.add_rounded, color: Colors.white)),
                ),
              ]),
            ),
            Expanded(
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('🌱', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  Text(l.noActiveCrops, style: AppTextStyles.headlineMedium),
                  const SizedBox(height: 8),
                  Text(l.addFirstCrop, style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.cropAdd),
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), gradient: AppColors.primaryGradient), child: Text(l.addCrop, style: AppTextStyles.labelLarge)),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
