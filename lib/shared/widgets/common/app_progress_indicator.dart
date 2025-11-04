import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';

/// AppProgressIndicator - مؤشر تقدم موحد
class AppProgressIndicator extends StatelessWidget {
  final double value;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final bool showPercentage;
  final BorderRadius? borderRadius;

  const AppProgressIndicator({
    Key? key,
    required this.value,
    this.height = 8.0,
    this.backgroundColor,
    this.progressColor,
    this.showPercentage = true,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showPercentage)
          Padding(
            padding: EdgeInsets.only(bottom: DesignSystem.sm),
            child: Text(
              '%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: progressColor ?? AppColors.primary,
              ),
            ),
          ),
        ClipRRect(
          borderRadius: borderRadius ??
              BorderRadius.circular(DesignSystem.radiusXs),
          child: LinearProgressIndicator(
            value: value.clamp(0.0, 1.0),
            minHeight: height,
            backgroundColor:
                backgroundColor ?? AppColors.textLight.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              progressColor ?? AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
