import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';

/// SearchEmptyState - حالة فارغة عندما لا توجد نتائج بحث
class SearchEmptyState extends StatelessWidget {
  final String? messageKey;
  final String? customMessage;
  final VoidCallback? onRetry;
  final bool showRetryButton;

  const SearchEmptyState({
    super.key,
    this.messageKey = 'search_no_results',
    this.customMessage,
    this.onRetry,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _EmptyStateContent(
          messageKey: messageKey,
          customMessage: customMessage,
          onRetry: onRetry,
          showRetryButton: showRetryButton,
        ),
      ),
    );
  }
}

class _EmptyStateContent extends StatelessWidget {
  final String? messageKey;
  final String? customMessage;
  final VoidCallback? onRetry;
  final bool showRetryButton;

  const _EmptyStateContent({
    required this.messageKey,
    required this.customMessage,
    required this.onRetry,
    required this.showRetryButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignSystem.base,
        vertical: DesignSystem.xxl,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty State Icon
          Container(
            padding: const EdgeInsets.all(DesignSystem.lg),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 4.h,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: DesignSystem.xl),
          // Main Message
          AppText(
            messageKey?.tr ?? customMessage ?? 'search_no_results'.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DesignSystem.md),
          // Secondary Message
          AppText(
            'try_different_keywords'.tr,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: DesignSystem.lineHeightRelaxed,
            ),
            textAlign: TextAlign.center,
          ),
          // Retry Button
          if (showRetryButton && onRetry != null) ...[
            const SizedBox(height: DesignSystem.xl),
            AppButton(
              onPressed: onRetry!,
              label: 'retry_action'.tr,
              backgroundColor: AppColors.primary,
              width: 60.w,
              height: DesignSystem.buttonHeightBase,
            ),
          ],
        ],
      ),
    );
  }
}