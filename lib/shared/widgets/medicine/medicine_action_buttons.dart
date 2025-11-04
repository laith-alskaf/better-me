import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:BetterMe/shared/widgets/buttons/app_button.dart';

/// MedicineActionButtons - أزرار الإجراءات للدواء (تعديل، حذف، إلخ)
class MedicineActionButtons extends StatelessWidget {
  const MedicineActionButtons({
    Key? key,
    this.onMarkTaken,
    this.onEdit,
    this.onDelete,
    this.isTaken = false,
  }) : super(key: key);

  final VoidCallback? onMarkTaken;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isTaken;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onMarkTaken != null)
          Expanded(
            child: AppButton(
              onPressed: onMarkTaken!,
              label: isTaken ? 'taken'.tr : 'mark_as_taken'.tr,
              backgroundColor: isTaken ? AppColors.success : AppColors.primary,
              foregroundColor: AppColors.background,
              icon: Icons.check_circle_outline,
              height: DesignSystem.buttonHeightSmall,
            ),
          ),
        if (onMarkTaken != null && onEdit != null)
          SizedBox(width: DesignSystem.base.w),
        if (onEdit != null)
          Expanded(
            child: AppButton(
              onPressed: onEdit!,
              label: 'edit_medicine'.tr,
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.background,
              icon: Icons.edit,
              height: DesignSystem.buttonHeightSmall,
            ),
          ),
        if (onEdit != null && onDelete != null)
          SizedBox(width: DesignSystem.base.w),
        if (onDelete != null)
          Expanded(
            child: AppButton(
              onPressed: onDelete!,
              label: 'delete_medicine'.tr,
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.background,
              icon: Icons.delete,
              height: DesignSystem.buttonHeightSmall,
            ),
          ),
      ],
    );
  }
}

/// MedicineInfoItem - عنصر معلومة بسيط للدواء
class MedicineInfoItem extends StatelessWidget {
  const MedicineInfoItem({
    Key? key,
    required this.label,
    required this.value,
    this.icon,
    this.backgroundColor,
  }) : super(key: key);

  final String label;
  final String value;
  final IconData? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DesignSystem.paddingBase,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
        border: Border.all(
          color: AppColors.outline,
          width: DesignSystem.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
            ),
            SizedBox(width: DesignSystem.base.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: DesignSystem.xs.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// MedicineReminderBanner - بنر تنبيه الدواء
class MedicineReminderBanner extends StatelessWidget {
  const MedicineReminderBanner({
    Key? key,
    required this.medicineName,
    required this.dosage,
    required this.nextTime,
    this.onDismiss,
    this.onTakeMedicine,
  }) : super(key: key);

  final String medicineName;
  final String dosage;
  final String nextTime;
  final VoidCallback? onDismiss;
  final VoidCallback? onTakeMedicine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: DesignSystem.paddingBase,
      padding: DesignSystem.paddingBase,
      decoration: BoxDecoration(
        color: AppColors.warning50,
        borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
        border: Border.all(
          color: AppColors.warning,
          width: DesignSystem.borderWidthBase,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: AppColors.warning,
                size: 24.sp,
              ),
              SizedBox(width: DesignSystem.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'take_medicine_reminder'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: DesignSystem.xs.h),
                    Text(
                      '$medicineName - $dosage',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (onDismiss != null)
                GestureDetector(
                  onTap: onDismiss,
                  child: Icon(
                    Icons.close,
                    color: AppColors.textTertiary,
                    size: 20.sp,
                  ),
                ),
            ],
          ),
          SizedBox(height: DesignSystem.base.h),
          if (onTakeMedicine != null)
            SizedBox(
              width: double.infinity,
              height: DesignSystem.buttonHeightSmall,
              child: AppButton(
                onPressed: onTakeMedicine!,
                label: 'mark_as_taken'.tr,
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.background,
                icon: Icons.check,
              ),
            ),
        ],
      ),
    );
  }
}