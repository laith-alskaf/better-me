import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';

/// EmptyMedicineState - حالة الفراغ عند عدم وجود أدوية
/// يوفر واجهة جميلة وتحفيزية لإضافة أول دواء
class EmptyMedicineState extends StatelessWidget {
  const EmptyMedicineState({
    Key? key,
    this.onAddPressed,
    this.title = 'no_medicines',
    this.subtitle = 'add_first_medicine',
    this.actionButtonText = 'add',
  }) : super(key: key);

  final VoidCallback? onAddPressed;
  final String title;
  final String subtitle;
  final String actionButtonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Container with Gradient Background
          AnimatedContainer(
            duration: DesignSystem.transitionMedium,
            curve: DesignSystem.curveSmooth,
            width: 100.w * 0.28,
            height: 100.w * 0.28,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.12),
                  AppColors.secondary.withOpacity(0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(DesignSystem.radiusModernExtraLarge),
              boxShadow: DesignSystem.shadowModernMedium,
              border: Border.all(
                color: AppColors.primary.withOpacity(0.15),
                width: DesignSystem.borderWidthThin,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.medication_liquid_outlined,
                size: 50.sp,
                color: AppColors.primary,
              ),
            ),
          ),

          SizedBox(height: DesignSystem.lg.h),

          // Title
          Text(
            title.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: DesignSystem.lineHeightNormal,
            ),
          ),

          SizedBox(height: DesignSystem.md.h),

          // Subtitle
          Padding(
            padding: DesignSystem.paddingSymmetricHorizontalBase,
            child: Text(
              subtitle.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                height: DesignSystem.lineHeightRelaxed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: DesignSystem.xxl.h),

          // Action Button with Gradient
          if (onAddPressed != null)
            Padding(
              padding: DesignSystem.paddingSymmetricHorizontalLg,
              child: AppButton(
                onPressed: onAddPressed!,
                label: actionButtonText.tr,
                width: double.infinity,
                height: DesignSystem.buttonHeightBase,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}