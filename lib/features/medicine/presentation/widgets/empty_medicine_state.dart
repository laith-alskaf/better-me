import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';

class EmptyMedicineState extends StatelessWidget {
  final VoidCallback onAddPressed;

  const EmptyMedicineState({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: DesignSystem.paddingBase,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DesignSystem.radiusLg),
              ),
              child: Icon(
                Icons.medication_outlined,
                size: 40.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: DesignSystem.lg.h),
            Text(
              'no_medicines'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          
           
          ],
        ),
      ),
    );
  }
}