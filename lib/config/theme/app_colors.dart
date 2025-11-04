import 'package:flutter/material.dart';

/// App Colors Configuration - Centralized color palette for entire application
/// يحتوي على جميع الألوان المستخدمة في التطبيق
/// تم تحسينها لتكون أجمل وأكثر توازناً مع دعم Material Design 3
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ===== PRIMARY COLORS (Green Wellness Theme) =====
  /// اللون الأخضر الأساسي - يعكس الصحة والعافية
  static const Color primary = Color(0xFF7CBD43);
  static const Color primaryLight = Color(0xFFB8E6A0);
  static const Color primaryDark = Color(0xFF5DA630);
  static const Color primaryExtraDark = Color(0xFF4A8621);
  
  // ===== PRIMARY TINT SHADES =====
  static const Color primary50 = Color(0xFFF1F8E9);
  static const Color primary100 = Color(0xFFDCF4C8);
  static const Color primary200 = Color(0xFFC3ECA3);
  static const Color primary300 = Color(0xFFA9E57E);
  static const Color primary400 = Color(0xFF93DD6A);
  static const Color primary500 = Color(0xFF7CBD43);
  static const Color primary600 = Color(0xFF68A940);
  static const Color primary700 = Color(0xFF56943B);
  static const Color primary800 = Color(0xFF468035);
  static const Color primary900 = Color(0xFF2D5A23);

  // ===== SECONDARY COLORS (Purple Accent) =====
  /// لون ثانوي - بنفسجي حديث للتركيزات
  static const Color secondary = Color(0xFF8B7FBD);
  static const Color secondaryLight = Color(0xFFC5B8E9);
  static const Color secondaryDark = Color(0xFF5B5299);
  
  // ===== SECONDARY TINT SHADES =====
  static const Color secondary50 = Color(0xFFF5F1FF);
  static const Color secondary100 = Color(0xFFEBDEFF);
  static const Color secondary200 = Color(0xFFDECAFF);
  static const Color secondary300 = Color(0xFFC5B8E9);
  static const Color secondary400 = Color(0xFFA999D7);
  static const Color secondary500 = Color(0xFF8B7FBD);
  static const Color secondary600 = Color(0xFF6B67A5);
  static const Color secondary700 = Color(0xFF5B5299);
  static const Color secondary800 = Color(0xFF4B4684);
  static const Color secondary900 = Color(0xFF3A3570);

  // ===== NEUTRAL COLORS (Backgrounds & Surfaces) =====
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F9FA);
  static const Color surfaceVariant = Color(0xFFF0F0F0);
  static const Color outline = Color(0xFFD8D8D8);
  static const Color outlineVariant = Color(0xFFE8E8E8);

  // ===== STATUS COLORS =====
  /// أحمر للأخطاء
  static const Color error = Color(0xFFD32F2F);
  static const Color error50 = Color(0xFFFCE4EC);
  static const Color error100 = Color(0xFFF8BBD0);
  
  /// برتقالي للتحذيرات
  static const Color warning = Color(0xFFF57C00);
  static const Color warning50 = Color(0xFFFFF3E0);
  static const Color warning100 = Color(0xFFFFE0B2);
  
  /// أخضر للنجاح
  static const Color success = Color(0xFF388E3C);
  static const Color success50 = Color(0xFFE8F5E9);
  static const Color success100 = Color(0xFFC8E6C9);
  
  /// أزرق للمعلومات
  static const Color info = Color(0xFF1976D2);
  static const Color info50 = Color(0xFFE3F2FD);
  static const Color info100 = Color(0xFFBBDEFB);

  // ===== TEXT COLORS (Typography) =====
  static const Color textPrimary = Color(0xFF1F1F1F);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textLight = Color(0xFFE0E0E0);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // ===== STATUS INDICATORS =====
  static const Color online = Color(0xFF388E3C);
  static const Color offline = Color(0xFF9E9E9E);

  // ===== FEATURE-SPECIFIC COLORS =====
  
  /// ألوان حاسبة الصحة (Calculator Feature)
  /// كل حاسبة لها لون مميز
  static const Color calculatorBmi = Color(0xFFF57C00);          // برتقالي - BMI
  static const Color calculatorCalories = Color(0xFFD32F2F);     // أحمر - السعرات
  static const Color calculatorPerfectWeight = Color(0xFF8B7FBD); // بنفسجي - الوزن المثالي
  static const Color calculatorBloodPressure = Color(0xFF1976D2); // أزرق - ضغط الدم
  static const Color calculatorFatEating = Color(0xFFF57C00);    // برتقالي - الدهون
  static const Color calculatorSmokingCost = Color(0xFFD32F2F);  // أحمر - التدخين
  static const Color calculatorWaterNeed = Color(0xFF1976D2);    // أزرق - الماء
  static const Color calculatorGreyBackground = Color(0xFFF5F5F5); // رمادي فاتح - الخلفية

  /// ألوان ميزة الأدوية (Medicine Feature)
  static const Color medicinePrimary = Color(0xFF1976D2);        // أزرق أساسي
  static const Color medicineScaffold = Color(0xFFF8F9FA);       // خلفية بيضاء ناعمة
  static const Color medicineSecondary = Color(0xFFD32F2F);      // أحمر ثانوي
  static const Color medicineAccent = Color(0xFF00897B);         // تركواز
  static const Color medicineErrorBorder = Color(0xFFD32F2F);    // أحمر للخطأ
  static const Color medicineTextLight = Color(0xFFBDBDBD);      // نص خفيف
  static const Color medicineText = Color(0xFF424242);           // نص أساسي
}
