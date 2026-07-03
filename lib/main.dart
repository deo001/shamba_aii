import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shamba_ai/core/services/storage_service.dart';
import 'package:shamba_ai/core/services/locale_service.dart';
import 'package:shamba_ai/core/theme/app_theme.dart';
import 'package:shamba_ai/l10n/app_localizations.dart';
import 'package:shamba_ai/routes/app_pages.dart';
import 'package:shamba_ai/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for offline storage
  await Hive.initFlutter();

  // Initialize core services
  await StorageService.init();

  runApp(const ShambaAIApp());
}

class ShambaAIApp extends StatelessWidget {
  const ShambaAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ShambaAI',
      debugShowCheckedModeBanner: false,

      // ── Theme ──────────────────────────────────────────────────────
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      // ── Localization ───────────────────────────────────────────────
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('sw'),
      ],
      locale: LocaleService.getSavedLocale(),
      localeResolutionCallback: (locale, supportedLocales) {
        for (final supported in supportedLocales) {
          if (locale?.languageCode == supported.languageCode) {
            return supported;
          }
        }
        return const Locale('en');
      },

      // ── GetX locale ────────────────────────────────────────────────
      translations: AppTranslations(),
      fallbackLocale: const Locale('en', 'US'),

      // ── Navigation ─────────────────────────────────────────────────
      initialRoute: AppRoutes.languageSelect,
      getPages: AppPages.pages,

      // ── Default Transitions ────────────────────────────────────────
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}

/// GetX translations class (wraps ARB strings for GetX .tr support)
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => const {
        'en_US': {},
        'sw_TZ': {},
      };
}
