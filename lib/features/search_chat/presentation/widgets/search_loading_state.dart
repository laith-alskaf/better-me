import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';

/// SearchLoadingState - حالة التحميل أثناء البحث
class SearchLoadingState extends StatelessWidget {
  final String? messageKey;
  final String? customMessage;

  const SearchLoadingState({
    super.key,
    this.messageKey = 'thank_you_for_asking',
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DesignSystem.base,
            vertical: DesignSystem.xxl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Loading Animation - Animated Circle
              Container(
                width: 5.h,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Rotating circle
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 2 * 3.14159),
                      duration: const Duration(seconds: 3),
                      builder: (context, value, child) {
                        return Transform.rotate(
                          angle: value,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      onEnd: () {
                        // Continue animation
                      },
                    ),
                    // Center icon
                    Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: DesignSystem.iconLg,
                    ),
                  ],
                ),
              ),
              SizedBox(height: DesignSystem.xl),
              // Loading Message
              AppText(
                messageKey?.tr ?? customMessage ?? 'thank_you_for_asking'.tr,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  height: DesignSystem.lineHeightRelaxed,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: DesignSystem.lg),
              // Animated dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnimatedDot(0),
                  SizedBox(width: DesignSystem.sm),
                  _buildAnimatedDot(1),
                  SizedBox(width: DesignSystem.sm),
                  _buildAnimatedDot(2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// بناء نقطة متحركة
  Widget _buildAnimatedDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.5 + (value * 0.5),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.3 + (value * 0.7)),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      onEnd: () {
        // Animation will repeat via the TweenAnimationBuilder
      },
    );
  }
}