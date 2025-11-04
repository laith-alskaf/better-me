import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/localization/localization_controller.dart';

/// AppAlertDialog - نافذة تنبيه/تأكيد موحدة
class AppAlertDialog {
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    bool isArabic = LocalizationController.instance.isArabic;

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textLight.withOpacity(0.8),
            ),
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          ),
          backgroundColor: AppColors.background,
          actions: [
            if (cancelButtonText != null)
              TextButton(
                onPressed: () {
                  onCancel?.call();
                  Navigator.of(context).pop();
                },
                child: Text(
                  cancelButtonText,
                  style:const  TextStyle(
                    color: AppColors.textLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            TextButton(
              onPressed: () {
                onConfirm?.call();
                Navigator.of(context).pop();
              },
              child: Text(
                confirmButtonText ?? 'OK',
                style:const  TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
