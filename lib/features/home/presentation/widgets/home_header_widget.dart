import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

/// Header widget for Home screen
/// يعرض تحية ديناميكية مع عنوان "أخبار الصحة"
class HomeHeaderWidget extends StatelessWidget {
  final Color? textColor;
  final bool showDivider;

  const HomeHeaderWidget({
    Key? key,
    this.textColor,
    this.showDivider = false,
  }) : super(key: key);

  /// الحصول على رسالة تحية بناءً على وقت اليوم
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'good_morning'.tr; // صباح الخير
    } else if (hour < 17) {
      return 'good_afternoon'.tr; // مساء الخير
    } else {
      return 'good_evening'.tr; // تمساء الخير
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting with dynamic time-based message - تصميم هادئ ومريح
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    _getGreeting(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: DesignSystem.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        color: AppColors.primary.withValues(alpha: 0.6),
                        size: DesignSystem.iconBase,
                      ),
                      const SizedBox(width: DesignSystem.sm),
                      Expanded(
                        child: AppText(
                          'the_news_of_healthy'.tr,
                          style: TextStyle(
                            fontSize: DesignSystem.bodyLarge.fontSize,
                            fontWeight: FontWeight.w600,
                            color: textColor ?? AppColors.textPrimary,
                            height: DesignSystem.lineHeightTight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: DesignSystem.md),
            // Profile emoji/icon - تصميم بسيط هادئ
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  width: DesignSystem.borderWidthBase,
                ),
              ),
              child: const Center(
                child: Text(
                  '👋',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: DesignSystem.lg),
          const AppDivider(
            margin: EdgeInsets.symmetric(horizontal: DesignSystem.base),
          ),
        ]
      ],
    );
  }
}