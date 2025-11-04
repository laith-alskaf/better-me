import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';

/// AppLoadingDialog - نافذة تحميل موحدة
class AppLoadingDialog {
  static void show(
    BuildContext context, {
    String? message,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return _AppLoadingWidget(message: message);
      },
    );
  }

  static void dismiss(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}

class _AppLoadingWidget extends StatelessWidget {
  final String? message;

  const _AppLoadingWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(DesignSystem.xl),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
            boxShadow: DesignSystem.shadowElevation12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: DesignSystem.iconXxl,
                height: DesignSystem.iconXxl,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: DesignSystem.borderWidthMedium,
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: DesignSystem.base),
                Text(
                  message!,
                  style:const  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
