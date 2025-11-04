import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';

/// AppDivider - فاصل موحد مع خيارات متعددة
class AppDivider extends StatelessWidget {
  final double height;
  final double? thickness;
  final Color? color;
  final EdgeInsets? margin;
  final bool horizontal;

  const AppDivider({
    Key? key,
    this.height = 1.0,
    this.thickness,
    this.color,
    this.margin,
    this.horizontal = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? AppColors.textLight.withOpacity(0.2);
    final dividerThickness = thickness ?? DesignSystem.borderWidthBase;

    if (horizontal) {
      return Padding(
        padding: margin ?? EdgeInsets.symmetric(vertical: DesignSystem.md),
        child: Divider(
          height: height,
          thickness: dividerThickness,
          color: dividerColor,
        ),
      );
    } else {
      return Padding(
        padding: margin ?? EdgeInsets.symmetric(horizontal: DesignSystem.md),
        child: SizedBox(
          width: dividerThickness,
          height: height,
          child: DecoratedBox(
            decoration: BoxDecoration(color: dividerColor),
          ),
        ),
      );
    }
  }
}
