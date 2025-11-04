import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:get/utils.dart';
import 'package:sizer/sizer.dart';
import '../widgets/shared_gridview.dart';
import '../../widgets/text_healthy_data.dart';

/// Health tips list widget
/// عرض قائمة النصائح الصحية بصيغة قابلة للتوسع مع تصميم محسّن ومريح للعين
class HomeHealthTipsWidget extends StatelessWidget {
  final List<List<String>>? tipsData;
  final bool showDivider;
  final EdgeInsets? padding;

  const HomeHealthTipsWidget({
    Key? key,
    this.tipsData,
    this.showDivider = true,
    this.padding,
  }) : super(key: key);

  /// Get icon and color for each tip - تقليل الألوان الزاهية
  Map<String, dynamic> _getTipIcon(int index) {
    final icons = [
      {
        'icon': Icons.water_drop_rounded,
        'color': AppColors.primary.withOpacity(0.6), // تقليل التشبع
      },
      {
        'icon': Icons.fastfood,
        'color': AppColors.warning.withOpacity(0.6),
      },
      {
        'icon': Icons.hotel,
        'color': AppColors.secondary.withOpacity(0.6),
      },
      {
        'icon': Icons.fitness_center,
        'color': AppColors.calculatorBmi.withOpacity(0.6),
      },
      {
        'icon': Icons.spa,
        'color': AppColors.primary.withOpacity(0.5),
      },
      {
        'icon': Icons.monitor_heart,
        'color': AppColors.error.withOpacity(0.6),
      },
      {
        'icon': Icons.smoke_free,
        'color': AppColors.calculatorSmokingCost.withOpacity(0.6),
      },
    ];

    return icons[index % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    final data = tipsData ?? healthTipsData;

    return Column(
      children: [
        // Section header - تصميم أنظف وأقل تعقيداً
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DesignSystem.base),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(DesignSystem.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius:
                            BorderRadius.circular(DesignSystem.radiusMd),
                      ),
                      child: Icon(
                        Icons.lightbulb_rounded,
                        color: AppColors.primary.withOpacity(0.7),
                        size: DesignSystem.iconMd,
                      ),
                    ),
                    SizedBox(width: DesignSystem.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'expert_tips'.tr,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          AppText(
                            'health_recommendations'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: DesignSystem.md),
              // Count badge - تصميم بسيط هادئ
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DesignSystem.base,
                  vertical: DesignSystem.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(DesignSystem.radiusXl),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: AppText(
                  '${data.length}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: DesignSystem.xl),

        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignSystem.base),
            child: AppDivider(
              margin: EdgeInsets.only(bottom: DesignSystem.lg),
            ),
          ),

        // Tips list
        Padding(
          padding: padding ?? EdgeInsets.zero,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final tipConfig = _getTipIcon(index);
              return SharedGridview(
                text: data[index][0],
                icon: tipConfig['icon'],
                accentColor: tipConfig['color'],
                listOfText: AppText(
                  data[index][1],
                  color: AppColors.textSecondary,
                  maxLines: null, // عرض المحتوى كاملاً بدون تقييد
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.7,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}