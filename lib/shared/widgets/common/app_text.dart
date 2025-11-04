import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/localization/localization_controller.dart';

/// AppText - مكون نصي موحد وقابل للتخصيص
/// يوفر أنماط مختلفة من النصوص مع دعم RTL/LTR تلقائي
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? lineHeight;

  /// أنماط مدمجة
  static TextStyle heading1 =const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: DesignSystem.lineHeightTight,
  );

  static TextStyle heading2 =const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: DesignSystem.lineHeightNormal,
  );

  static TextStyle heading3 =const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: DesignSystem.lineHeightNormal,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: DesignSystem.lineHeightRelaxed,
  );

  static TextStyle bodyMedium =const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: DesignSystem.lineHeightRelaxed,
  );

  static TextStyle bodySmall =const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
    height: DesignSystem.lineHeightNormal,
  );

  static TextStyle caption = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: DesignSystem.lineHeightNormal,
  );

  const AppText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.lineHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isArabic = LocalizationController.instance.isArabic;

    return Text(
      text,
      style: style ??
          TextStyle(
            color: color ?? AppColors.textPrimary,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w400,
            letterSpacing: letterSpacing,
            height: lineHeight ?? DesignSystem.lineHeightNormal,
          ),
      textAlign: textAlign,
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
