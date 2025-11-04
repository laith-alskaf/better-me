import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:sizer/sizer.dart';

/// Quick Stats Widget - عرض إحصائيات صحية سريعة
/// يعرض 3 بطاقات مع معلومات صحية أساسية
class QuickStatsWidget extends StatelessWidget {
  const QuickStatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _StatCard(
            icon: Icons.favorite,
            label: 'Heart Rate',
            value: '72',
            unit: 'bpm',
            color: AppColors.error,
            backgroundColor: AppColors.error50,
          ),
          SizedBox(width: DesignSystem.md),
          _StatCard(
            icon: Icons.local_drink,
            label: 'Water Intake',
            value: '6',
            unit: 'cups',
            color: AppColors.info,
            backgroundColor: AppColors.info50,
          ),
          SizedBox(width: DesignSystem.md),
          _StatCard(
            icon: Icons.directions_walk,
            label: 'Steps Today',
            value: '8.5k',
            unit: 'steps',
            color: AppColors.primary,
            backgroundColor: AppColors.primary50,
          ),
        ],
      ),
    );
  }
}

/// Individual stat card widget - متجاوب وألوان هادئة
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;
  final Color backgroundColor;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final mutedColor = color.withOpacity(0.6);
    return Container(
      width: 28.w,
      padding: EdgeInsets.all(DesignSystem.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: mutedColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon background - لون أهدأ
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: mutedColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
            ),
            child: Icon(
              icon,
              color: mutedColor,
              size: DesignSystem.iconLg,
            ),
          ),
          SizedBox(height: DesignSystem.sm),
          // Label - حجم مناسب
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: DesignSystem.xs),
          // Value with unit
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: ' ${unit.isEmpty ? '' : unit}',
                  style: TextStyle(
                    fontSize: 8.5.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}