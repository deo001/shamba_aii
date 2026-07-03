import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_ai/core/services/storage_service.dart';

class LocaleService {
  static const _defaultLocale = Locale('en');

  static Locale getSavedLocale() {
    final lang = StorageService.getLanguage();
    if (lang == null) return _defaultLocale;
    return Locale(lang);
  }

  static Future<void> changeLocale(String languageCode) async {
    await StorageService.setLanguage(languageCode);
    final locale = Locale(languageCode);
    Get.updateLocale(locale);
  }

  static bool isLanguageSelected() {
    return StorageService.getLanguage() != null;
  }
}
