import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'app_colors.dart';
import 'design_system.dart';

/// AppTheme - نظام الـ Theme الموحد للتطبيق
/// يحتوي على ThemeData كامل مع دعم Material Design 3
class AppTheme {
  AppTheme._(); // Private constructor

  // ===== LIGHT THEME =====
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // ===== PRIMARY COLOR SCHEME =====
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surface,
        background: AppColors.background,
      ),

      // ===== SCAFFOLD BACKGROUND =====
      scaffoldBackgroundColor: AppColors.background,

      // ===== APP BAR THEME =====
      appBarTheme: AppBarTheme(
        elevation: DesignSystem.elevationMedium,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          height: DesignSystem.lineHeightNormal,
        ),
        iconTheme: IconThemeData(
          color: AppColors.primary,
          size: DesignSystem.iconBase,
        ),
        toolbarHeight: DesignSystem.getResponsiveHeight(8),
        surfaceTintColor: Colors.transparent,
      ),

      // ===== TEXT THEME =====
      textTheme: _buildTextTheme(),

      // ===== INPUT DECORATION THEME =====
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: DesignSystem.base,
          vertical: DesignSystem.base,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          borderSide: const BorderSide(
            color: AppColors.textLight,
            width: DesignSystem.borderWidthBase,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          borderSide: const BorderSide(
            color: AppColors.textLight,
            width: DesignSystem.borderWidthBase,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: DesignSystem.borderWidthMedium,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: DesignSystem.borderWidthBase,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: DesignSystem.borderWidthMedium,
          ),
        ),
        hintStyle: TextStyle(
          color: AppColors.textHint,
          fontSize: 14.sp,
        ),
        labelStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ===== BUTTON THEMES =====
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: DesignSystem.elevationMedium,
          padding: EdgeInsets.symmetric(
            horizontal: DesignSystem.buttonPaddingHorizontalBase,
            vertical: DesignSystem.buttonPaddingVerticalBase,
          ),
          minimumSize: Size(
            0,
            DesignSystem.buttonHeightBase,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          ),
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: DesignSystem.lineHeightNormal,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(
            color: AppColors.primary,
            width: DesignSystem.borderWidthBase,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: DesignSystem.buttonPaddingHorizontalBase,
            vertical: DesignSystem.buttonPaddingVerticalBase,
          ),
          minimumSize: Size(
            0,
            DesignSystem.buttonHeightBase,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          ),
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: DesignSystem.lineHeightNormal,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: DesignSystem.buttonPaddingHorizontalBase,
            vertical: DesignSystem.buttonPaddingVerticalSm,
          ),
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ===== CARD THEME =====
      cardTheme: CardTheme(
        color: AppColors.background,
        elevation: DesignSystem.elevationLow,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
        ),
      ),

      // ===== CHIP THEME =====
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: DesignSystem.base,
          vertical: DesignSystem.sm,
        ),
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
        ),
      ),

      // ===== PROGRESS INDICATOR THEME =====
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearMinHeight: 4.0,
        circularTrackColor: AppColors.surface,
      ),

      // ===== BOTTOM SHEET THEME =====
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.background,
        elevation: DesignSystem.elevationHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(DesignSystem.radiusLg),
            topRight: Radius.circular(DesignSystem.radiusLg),
          ),
        ),
      ),

      // ===== DIALOG THEME =====
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.background,
        elevation: DesignSystem.elevationVeryHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusLg),
        ),
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        contentTextStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
        ),
      ),

      // ===== FLOATING ACTION BUTTON THEME =====
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: DesignSystem.elevationMedium,
        highlightElevation: DesignSystem.elevationHigh,
        splashColor: AppColors.primaryDark.withOpacity(0.2),
        focusColor: AppColors.primaryDark.withOpacity(0.15),
        hoverColor: AppColors.primaryDark.withOpacity(0.1),
        disabledElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusModernLarge),
        ),
      ),

      // ===== DIVIDER THEME =====
      dividerTheme: DividerThemeData(
        color: AppColors.textLight,
        thickness: DesignSystem.borderWidthBase,
        space: DesignSystem.base,
      ),

      // ===== SNACK BAR THEME =====
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusModernMedium),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: DesignSystem.elevationHigh,
      ),

      // ===== BOTTOM NAVIGATION BAR THEME =====
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        elevation: DesignSystem.elevationMedium,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedIconTheme: IconThemeData(
          size: DesignSystem.iconBase,
          color: AppColors.primary,
        ),
        unselectedIconTheme: IconThemeData(
          size: DesignSystem.iconBase,
          color: AppColors.textSecondary,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ===== ADDITIONAL THEME SETTINGS =====
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ===== TEXT THEME BUILDER =====
  static TextTheme _buildTextTheme() {
    return TextTheme(
      /// Display Styles - الأكبر للعناوين الرئيسية
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightTight,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightTight,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightTight,
      ),

      /// Headline Styles - للعناوين الفرعية والعناوين الهامة
      headlineLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightNormal,
      ),
      headlineMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightNormal,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightNormal,
      ),

      /// Title Styles - للعناوين الثانوية
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightNormal,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightNormal,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightNormal,
      ),

      /// Body Styles - للنصوص الأساسية
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightRelaxed,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightRelaxed,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        height: DesignSystem.lineHeightRelaxed,
      ),

      /// Label Styles - للتسميات والعلامات
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightNormal,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: DesignSystem.lineHeightNormal,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        height: DesignSystem.lineHeightTight,
      ),
    );
  }
}