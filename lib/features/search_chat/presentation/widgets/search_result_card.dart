import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';

/// SearchResultCard - بطاقة لعرض نتيجة بحث واحدة
class SearchResultCard extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback? onTap;
  final bool isExpanded;
  final ValueChanged<bool>? onExpandChanged;

  const SearchResultCard({
    super.key,
    required this.question,
    required this.answer,
    this.onTap,
    this.isExpanded = false,
    this.onExpandChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.base,
        vertical: DesignSystem.sm,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: AppCard(
          backgroundColor: Colors.white,
          elevation: 2,
          borderRadius: DesignSystem.radiusBase,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Header
              Padding(
                padding: EdgeInsets.all(DesignSystem.base),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question Icon
                    Container(
                      padding: EdgeInsets.all(DesignSystem.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                      ),
                      child: Icon(
                        Icons.help_outline_rounded,
                        color: AppColors.primary,
                        size: DesignSystem.iconMd,
                      ),
                    ),
                    const SizedBox(width: DesignSystem.base),
                    // Question Text - يظهر كاملاً
                    Expanded(
                      child: Text(
                        question,
                        softWrap: true,
                        maxLines: null,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: DesignSystem.bodyMedium.fontSize,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: DesignSystem.lineHeightNormal,
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignSystem.sm),
                    // Expand Icon
                    Icon(
                      isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                      color: AppColors.primary,
                      size: DesignSystem.iconMd,
                    ),
                  ],
                ),
              ),
              // Divider
              if (isExpanded)
                Container(
                  height: DesignSystem.borderWidthBase,
                  color: AppColors.outline.withValues(alpha: 0.5),
                ),
              // Answer Body (if expanded)
              if (isExpanded)
                Padding(
                  padding: EdgeInsets.all(DesignSystem.base),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        answer,
                        softWrap: true,
                        maxLines: null,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          height: DesignSystem.lineHeightRelaxed,
                        ),
                      ),
                      SizedBox(height: DesignSystem.md),
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              icon: Icons.thumb_up_outlined,
                              label: 'مفيد',
                              color: AppColors.success,
                            ),
                          ),
                          SizedBox(width: DesignSystem.sm),
                          Expanded(
                            child: _buildActionButton(
                              icon: Icons.thumb_down_outlined,
                              label: 'غير مفيد',
                              color: AppColors.warning,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// بناء زر الإجراء
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.sm,
        vertical: DesignSystem.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DesignSystem.radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: DesignSystem.iconSm),
          SizedBox(width: DesignSystem.xs),
          AppText(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}