import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';

/// SearchInputWidget - مربع إدخال البحث موحد وقابل للتخصيص
class SearchInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintTextKey;
  final VoidCallback onSearchPressed;
  final VoidCallback? onChatActionButton;
  final bool isLoading;
  final ValueChanged<String>? onChanged;

  const SearchInputWidget({
    Key? key,
    required this.controller,
    this.hintTextKey = 'search_placeholder_faq',
    required this.onSearchPressed,
    this.onChatActionButton,
    this.isLoading = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.base,
        vertical: DesignSystem.sm,
      ),
      child: AppTextFormField(
        controller: controller,
        hintText: hintTextKey.tr,
        readOnly: isLoading,
        onChanged: onChanged,
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.primary,
          size: DesignSystem.iconMd,
        ),
        suffixIcon: _buildSuffixIcon(),
      ),
    );
  }

  /// بناء أيقونة البادئة (حذف أو بحث أو تحميل)
  Widget? _buildSuffixIcon() {
    if (isLoading) {
      return const  Padding(
        padding: EdgeInsets.all(DesignSystem.sm),
        child: SizedBox(
          width: DesignSystem.iconMd,
          height: DesignSystem.iconMd,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
    }

    return IconButton(
      icon: Tooltip(
        message: 'ask_ai_question'.tr,
        child: Icon(
          Icons.chat_bubble_outline_rounded,
          color: AppColors.primary,
          // size: 20.sp,
        ),
      ),
      onPressed: isLoading
          ? null
          : onChatActionButton ??
              () {
                controller.clear();
              },
    );
  }
}
