import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';

/// أنواع الرسائل/الإشعارات
enum SnackBarType { success, error, warning, info }

/// AppSnackBar - إشعار موحد مع أنواع مختلفة
class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final snackBar = _buildSnackBar(
      message: message,
      type: type,
      duration: duration,
      action: action,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static SnackBar _buildSnackBar({
    required String message,
    required SnackBarType type,
    required Duration duration,
    SnackBarAction? action,
  }) {
    final colors = _getSnackBarColors(type);

    return SnackBar(
      content: Row(
        children: [
          Icon(
            _getIcon(type),
            color: Colors.white,
            size: DesignSystem.iconMd,
          ),
          SizedBox(width: DesignSystem.md),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colors['bg'],
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
      ),
      margin: EdgeInsets.all(DesignSystem.base),
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.base,
        vertical: DesignSystem.md,
      ),
      action: action,
    );
  }

  static Map<String, Color> _getSnackBarColors(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return {
          'bg': Colors.green.shade600,
          'text': Colors.white,
        };
      case SnackBarType.error:
        return {
          'bg': Colors.red.shade600,
          'text': Colors.white,
        };
      case SnackBarType.warning:
        return {
          'bg': Colors.orange.shade600,
          'text': Colors.white,
        };
      case SnackBarType.info:
        return {
          'bg': AppColors.primary,
          'text': Colors.white,
        };
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }
}
