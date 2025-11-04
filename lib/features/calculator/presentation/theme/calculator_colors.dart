import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// CalculatorColors - Unified color palette with reduced saturation
/// Consistent with Home page design for seamless app experience
class CalculatorColors {
  // Backgrounds - Light and neutral
  static Color greyBackground = Colors.white;
  static Color cardBackground = Colors.white;
  
  // Muted accent colors - 60% opacity for comfortable viewing
  static Color bmiColor = AppColors.calculatorBmi.withValues(alpha: 0.65);
  static Color caloriesColor = AppColors.calculatorCalories.withValues(alpha: 0.65);
  static Color perfectWeightColor = AppColors.calculatorPerfectWeight.withValues(alpha: 0.65);
  static Color bloodPressureColor = AppColors.calculatorBloodPressure.withValues(alpha: 0.65);
  static Color waterColor = AppColors.primary.withValues(alpha: 0.6);
  static Color fatEatingColor = AppColors.calculatorFatEating.withValues(alpha: 0.65);
  static Color smokingColor = AppColors.calculatorSmokingCost.withValues(alpha: 0.65);
  
  // Dark colors for AppBar - ensure text visibility
  static Color bmiAppBarColor = AppColors.calculatorBmi;
  static Color caloriesAppBarColor = AppColors.calculatorCalories;
  static Color perfectWeightAppBarColor = AppColors.calculatorPerfectWeight;
  static Color bloodPressureAppBarColor = AppColors.calculatorBloodPressure;
  static Color waterAppBarColor = AppColors.success;
  static Color fatEatingAppBarColor = AppColors.calculatorFatEating;
  static Color smokingAppBarColor = AppColors.calculatorSmokingCost;
  
  // Legacy color aliases - for backward compatibility
  static Color blue = AppColors.primary.withValues(alpha: 0.65);
  static Color lightGreen = AppColors.success.withValues(alpha: 0.65);
  static Color lightOrange = AppColors.warning.withValues(alpha: 0.65);
  static Color blackWithOpacity = Colors.black.withValues(alpha: 0.7);
  
  // AppBar text color - high contrast white
  static Color appBarTextColor = Colors.white;
  static Color appBarIconColor = Colors.white;
  
  // Text colors - Consistent with app
  static Color textPrimary = AppColors.textPrimary;
  static Color textSecondary = AppColors.textSecondary;
  static Color textLight = AppColors.textLight;
  
  // UI Elements
  static Color divider = AppColors.primary.withValues(alpha: 0.1);
  static Color inputBorder = AppColors.primary.withValues(alpha: 0.2);
  static Color shadow = Colors.grey.withValues(alpha: 0.08);
}
