import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';

class CropAddScreen extends StatelessWidget {
  const CropAddScreen({super.key});
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
                GestureDetector(onTap: () => Get.back(), child: Container(width: 44, height: 44, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppColors.bgCard, border: const Border.fromBorderSide(BorderSide(color: AppColors.border))), child: const Icon(Icons.close_rounded, color: AppColors.textPrimary, size: 22))),
                const SizedBox(width: 14),
                Text(l.addCrop, style: AppTextStyles.titleLarge),
              ]),
              const SizedBox(height: 28),
              Text(l.cropType, style: AppTextStyles.labelLarge),
              const SizedBox(height: 10),
              TextField(decoration: InputDecoration(hintText: l.cropTypeHint), style: AppTextStyles.bodyLarge),
              const SizedBox(height: 20),
              Text(l.plantingDate, style: AppTextStyles.labelLarge),
              const SizedBox(height: 10),
              TextField(decoration: const InputDecoration(hintText: 'Select date'), style: AppTextStyles.bodyLarge, readOnly: true),
              const SizedBox(height: 20),
              Text(l.notes, style: AppTextStyles.labelLarge),
              const SizedBox(height: 10),
              TextField(decoration: InputDecoration(hintText: l.notesHint), style: AppTextStyles.bodyLarge, maxLines: 3),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(width: double.infinity, height: 56, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: AppColors.primaryGradient), child: Center(child: Text(l.saveCrop, style: AppTextStyles.labelLarge.copyWith(fontSize: 16)))),
              ),
              const SizedBox(height: 24),
            ]),
          ),
        ),
      ),
    );
  }
}
