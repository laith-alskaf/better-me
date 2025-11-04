import 'package:BetterMe/config/localization/app_localizations.dart';
import 'package:BetterMe/config/localization/localization_controller.dart';
import 'package:BetterMe/config/routes/app_pages.dart';
import 'package:BetterMe/config/routes/app_routes.dart';
import 'package:BetterMe/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

/// Main App Widget
/// الـ Widget الرئيسي للتطبيق
/// يدير:
/// - نظام الترجمة واللغات (Arabic/English مع RTL/LTR)
/// - نظام الألوان والـ Theme الموحد
/// - التوجيه والمسارات
/// - حجم الشاشة والقيم المتجاوبة (Sizer)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationController = LocalizationController.instance;

    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'BetterMe - صحتك أولاً',
          debugShowCheckedModeBanner: false,

          // ===== LOCALIZATION SETTINGS =====
          // اللغة الحالية مع الدعم التلقائي للغة الجهاز
          locale: localizationController.currentLocale.value,
          fallbackLocale: const Locale('en', 'US'),
          supportedLocales: LocalizationController.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          translations: AppLocalizations(),

          // ===== THEME SETTINGS =====
          // استخدام Theme الموحد المحسّن
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,

          // ===== ROUTING SETTINGS =====
          initialRoute: AppRoutes.initialRoute,
          getPages: AppPages.pages,
          
          // ===== PERFORMANCE OPTIMIZATIONS =====
          // تجنب الرسائل الهامة في الـ Debug Mode (لا تأثير على الإنتاج)
          enableLog: false,
        );
      },
    );
  }
}
