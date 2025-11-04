import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

/// LocalizationController - إدارة اللغة وقيم الترجمة
/// يوفر دعم اللغات: العربية والإنجليزية
class LocalizationController extends GetxController {
  static LocalizationController get instance => Get.find();

  // Observable للغة الحالية مع قيمة افتراضية مؤقتة حتى الإقلاع
  final Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  // اللغات المدعومة
  static const List<Locale> supportedLocales = [
    Locale('ar', 'SA'),
    Locale('en', 'US'),
  ];

  // رموز اللغات
  static const Map<String, String> languageCodes = {
    'ar': 'العربية',
    'en': 'English',
  };

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadInitialLanguage();
  }

  /// تحميل اللغة الافتراضية - الأولوية للجهاز
  /// Priority: 1. Device System Locale 2. Saved Preference 3. Fallback (English)
  Future<void> _loadInitialLanguage() async {
    Locale? locale;

    // احصل على لغة الجهاز أولاً (PRIMARY)
    final systemLocale = Get.deviceLocale;
    if (systemLocale != null) {
      locale = _findSupportedLocale(systemLocale);
    }

    // إذا لم توجد لغة جهاز مدعومة، حاول الحصول على اللغة المحفوظة
    locale ??= Get.locale;

    // الخيار الأخير - اللغة الافتراضية (إنجليزي)
    locale ??= const Locale('en', 'US');

    // تطبيق اللغة
    await changeLanguage(locale);
  }

  /// تغيير اللغة
  Future<void> changeLanguage(Locale locale) async {
    currentLocale.value = locale;
    Get.updateLocale(locale);
    update();
  }

  /// البحث عن اللغة المدعومة
  Locale _findSupportedLocale(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  /// التحقق من أن اللغة الحالية عربية
  bool get isArabic => currentLocale.value.languageCode == 'ar';

  /// التحقق من أن الاتجاه يمين-لأسار (RTL)
  bool get isRTL => isArabic;

  /// الحصول على اتجاه النص
  TextDirection get textDirection => isRTL ? TextDirection.rtl : TextDirection.ltr;

  /// صيغة التاريخ المحلية
  String formatDate(DateTime date) {
    if (isArabic) {
      return intl.DateFormat('dd/MM/yyyy', 'ar_SA').format(date);
    }
    return intl.DateFormat('MM/dd/yyyy', 'en_US').format(date);
  }

  /// صيغة الوقت المحلية
  String formatTime(DateTime time) {
    if (isArabic) {
      return intl.DateFormat('HH:mm', 'ar_SA').format(time);
    }
    return intl.DateFormat('hh:mm a', 'en_US').format(time);
  }

  /// صيغة التاريخ والوقت المحليين
  String formatDateTime(DateTime dateTime) {
    if (isArabic) {
      return intl.DateFormat('dd/MM/yyyy HH:mm', 'ar_SA').format(dateTime);
    }
    return intl.DateFormat('MM/dd/yyyy hh:mm a', 'en_US').format(dateTime);
  }
}


