import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';

/// AppCard - بطاقة موحدة مع خيارات تصميمية
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final VoidCallback? onTap;
  final Duration? duration;
  final Curve? curve;

  const AppCard({
    Key? key,
    required this.child,
    this.padding,
    this.elevation,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.onTap,
    this.duration,
    this.curve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding ?? EdgeInsets.all(DesignSystem.base),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.background,
        borderRadius: BorderRadius.circular(
          borderRadius ?? DesignSystem.radiusBase,
        ),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: DesignSystem.borderWidthBase,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.textLight.withOpacity(0.1),
            blurRadius: elevation ?? DesignSystem.elevationLow,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            borderRadius ?? DesignSystem.radiusBase,
          ),
          child: card,
        ),
      );
    }

    return card;
  }
}
