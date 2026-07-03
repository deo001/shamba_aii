import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
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
                Expanded(child: Text(l.notifications, style: AppTextStyles.titleLarge)),
              ]),
            ),
            Expanded(
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('🔔', style: TextStyle(fontSize: 56)),
                  const SizedBox(height: 16),
                  Text(l.noNotifications, style: AppTextStyles.headlineMedium),
                  const SizedBox(height: 8),
                  Text('Check back for farming alerts & reminders', style: AppTextStyles.bodyLarge, textAlign: TextAlign.center),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
