import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';

class FarmProfileSetupScreen extends StatelessWidget {
  const FarmProfileSetupScreen({super.key});
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
              Row(children: [
                GestureDetector(onTap: () => Get.back(), child: Container(width: 44, height: 44, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppColors.bgCard, border: const Border.fromBorderSide(BorderSide(color: AppColors.border))), child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18))),
                const SizedBox(width: 14),
                Text('Setup Farm', style: AppTextStyles.titleLarge),
              ]),
              const SizedBox(height: 32),
              Text(l.farmName, style: AppTextStyles.labelLarge),
              const SizedBox(height: 10),
              TextField(decoration: InputDecoration(hintText: l.farmNameHint), style: AppTextStyles.bodyLarge),
              const SizedBox(height: 20),
              Text(l.farmSize, style: AppTextStyles.labelLarge),
              const SizedBox(height: 10),
              TextField(decoration: InputDecoration(hintText: l.farmSizeHint), style: AppTextStyles.bodyLarge, keyboardType: TextInputType.number),
              const Spacer(),
              GestureDetector(
                onTap: () { Get.back(); Get.back(); },
                child: Container(width: double.infinity, height: 56, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: AppColors.primaryGradient), child: Center(child: Text(l.saveProfile, style: AppTextStyles.labelLarge.copyWith(fontSize: 16)))),
              ),
              const SizedBox(height: 24),
            ]),
          ),
        ),
      ),
    );
  }
}
