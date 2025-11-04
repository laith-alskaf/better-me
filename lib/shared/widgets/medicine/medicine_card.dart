import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';

/// بطاقة الدواء - widget مشترك وقابل لإعادة الاستخدام
/// يتم استخدامه في قوائم الأدوية مع تصميم جذاب ومتناسق
class MedicineCard extends StatelessWidget {
  const MedicineCard({
    Key? key,
    required this.medicineName,
    required this.dosage,
    required this.medicineType,
    required this.frequency,
    this.status = 'pending',
    this.nextDose,
    this.icon,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.backgroundColor,
  }) : super(key: key);

  final String medicineName;
  final String dosage;
  final String medicineType;
  final String frequency;
  final String status;
  final String? nextDose;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Color? backgroundColor;

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'taken':
        return AppColors.success;
      case 'missed':
        return AppColors.error;
      case 'pending':
      default:
        return AppColors.warning;
    }
  }

  IconData _getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'taken':
        return Icons.check_circle;
      case 'missed':
        return Icons.cancel;
      case 'pending':
      default:
        return Icons.schedule;
    }
  }

  String _getStatusLabel() {
    switch (status.toLowerCase()) {
      case 'taken':
        return 'taken'.tr;
      case 'missed':
        return 'missed'.tr;
      case 'pending':
      default:
        return 'pending'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: DesignSystem.transitionMedium,
        curve: DesignSystem.curveSmooth,
        margin: EdgeInsets.symmetric(
          horizontal: DesignSystem.base.w,
          vertical: DesignSystem.sm.h,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.background,
          borderRadius: BorderRadius.circular(DesignSystem.radiusModernLarge),
          border: Border.all(
            color: AppColors.outline.withOpacity(0.5),
            width: DesignSystem.borderWidthThin,
          ),
          boxShadow: DesignSystem.shadowModernMedium,
        ),
        child: Padding(
          padding: DesignSystem.paddingBase,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Medicine Name and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Medicine Name
                        Text(
                          medicineName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: DesignSystem.sm.h),
                        // Dosage
                        Text(
                          '${'medicine_dosage'.tr}: $dosage',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: DesignSystem.base.w),
                  // Status Indicator with Modern Design
                  AnimatedContainer(
                    duration: DesignSystem.transitionMedium,
                    curve: DesignSystem.curveSmooth,
                    padding: EdgeInsets.all(DesignSystem.md),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withOpacity(0.08),
                      borderRadius: BorderRadius.circular(DesignSystem.radiusModernLarge),
                      border: Border.all(
                        color: _getStatusColor().withOpacity(0.2),
                        width: DesignSystem.borderWidthThin,
                      ),
                    ),
                    child: Icon(
                      _getStatusIcon(),
                      color: _getStatusColor(),
                      size: 24.sp,
                    ),
                  ),
                ],
              ),

              SizedBox(height: DesignSystem.base.h),

              // Medicine Details Row
              Row(
                children: [
                  // Medicine Type
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'type'.tr}:',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: DesignSystem.xs.h),
                        Text(
                          medicineType,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Frequency
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'medicine_frequency'.tr}:',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: DesignSystem.xs.h),
                        Text(
                          frequency,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Next Dose if available
              if (nextDose != null) ...[
                SizedBox(height: DesignSystem.base.h),
                AnimatedContainer(
                  duration: DesignSystem.transitionMedium,
                  curve: DesignSystem.curveSmooth,
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignSystem.md,
                    vertical: DesignSystem.sm,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.05),
                        AppColors.primary.withOpacity(0.02),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(DesignSystem.radiusModernMedium),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.15),
                      width: DesignSystem.borderWidthThin,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(DesignSystem.xs),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(DesignSystem.radiusModernSmall),
                        ),
                        child: Icon(
                          Icons.access_time_rounded,
                          size: 14.sp,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: DesignSystem.md.w),
                      Text(
                        '${'next_reminder'.tr}: $nextDose',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Actions Row
              if (onEdit != null || onDelete != null) ...[
                SizedBox(height: DesignSystem.base.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onEdit != null)
                      GestureDetector(
                        onTap: onEdit,
                        child: AnimatedContainer(
                          duration: DesignSystem.transitionMedium,
                          curve: DesignSystem.curveSmooth,
                          padding: EdgeInsets.symmetric(
                            horizontal: DesignSystem.md.w,
                            vertical: DesignSystem.xs.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondary.withOpacity(0.08),
                                AppColors.secondary.withOpacity(0.04),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(DesignSystem.radiusModernMedium),
                            border: Border.all(
                              color: AppColors.secondary.withOpacity(0.2),
                              width: DesignSystem.borderWidthThin,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_rounded,
                                size: 14.sp,
                                color: AppColors.secondary,
                              ),
                              SizedBox(width: DesignSystem.xs.w),
                              Text(
                                'edit_medicine'.tr,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (onEdit != null && onDelete != null)
                      SizedBox(width: DesignSystem.sm.w),
                    if (onDelete != null)
                      GestureDetector(
                        onTap: onDelete,
                        child: AnimatedContainer(
                          duration: DesignSystem.transitionMedium,
                          curve: DesignSystem.curveSmooth,
                          padding: EdgeInsets.symmetric(
                            horizontal: DesignSystem.md.w,
                            vertical: DesignSystem.xs.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.error.withOpacity(0.08),
                                AppColors.error.withOpacity(0.04),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(DesignSystem.radiusModernMedium),
                            border: Border.all(
                              color: AppColors.error.withOpacity(0.2),
                              width: DesignSystem.borderWidthThin,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_rounded,
                                size: 14.sp,
                                color: AppColors.error,
                              ),
                              SizedBox(width: DesignSystem.xs.w),
                              Text(
                                'delete_medicine'.tr,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}