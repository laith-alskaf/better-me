import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';

/// AppScaffoldAppBar - شريط علوي موحد مع دعم اللغات والاتجاهات المختلفة
/// يوفر عنوان مترجم، زر رجوع اختياري، وإجراءات قابلة للتخصيص
class AppScaffoldAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppScaffoldAppBar({
    Key? key,
    this.titleKey,
    this.title,
    this.centerTitle = true,
    this.showBackButton,
    this.backButtonIcon,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.elevation = DesignSystem.elevationNone,
    this.bottom,
  })  : assert(titleKey != null || title != null,
            'Either titleKey or title widget must be provided.'),
        super(key: key);

  /// مفتاح النص المترجم (يتم استخدامه مع `.tr`)
  final String? titleKey;

  /// عنصر مخصص لعنوان الـ AppBar في حال الحاجة إلى تخصيص متقدم
  final Widget? title;

  /// محاذاة العنوان في الوسط
  final bool centerTitle;

  /// التحكم بإظهار زر الرجوع بشكل صريح
  /// إذا كانت null سيتم تحديده تلقائياً حسب إمكانية الرجوع في الملاحة
  final bool? showBackButton;

  /// تخصيص أيقونة زر الرجوع
  final IconData? backButtonIcon;

  /// استدعاء مخصص عند الضغط على زر الرجوع
  final VoidCallback? onBackPressed;

  /// قائمة العناصر الإضافية على يمين الـ AppBar
  final List<Widget>? actions;

  /// لون الخلفية
  final Color? backgroundColor;

  /// ارتفاع الظل
  final double elevation;

  /// عنصر سفلي (مثل TabBar)
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    final shouldShowBack = showBackButton ?? canPop;
    final bgColor = backgroundColor ?? AppColors.primary;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bgColor,
            bgColor.withOpacity(0.85),
          ],
        ),
        boxShadow: DesignSystem.shadowModernHigh,
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: centerTitle,
        surfaceTintColor: Colors.transparent,
        leading: shouldShowBack
            ? _buildBackButton(context)
            : null,
        title: title ?? _buildTitle(context),
        toolbarHeight: (bottom != null)
            ? (DesignSystem.getResponsiveHeight(8) + bottom!.preferredSize.height)
            : DesignSystem.getResponsiveHeight(8),
        actions: _buildActions(),
        bottom: bottom,
      ),
    );
  }

  /// بناء زر الرجوع مع أنيميشن محسّن
  Widget _buildBackButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onBackPressed ?? () => Get.back(),
        borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
        child: Padding(
          padding: EdgeInsets.all(DesignSystem.sm),
          child: Icon(
            backButtonIcon ?? Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  /// بناء عنوان مترجم باستخدام `titleKey`
  Widget _buildTitle(BuildContext context) {
    return Container(
      padding:const  EdgeInsets.symmetric(
        horizontal: DesignSystem.sm,
        vertical: DesignSystem.xs,
      ),
      child: Text(
        titleKey?.tr ?? '',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: DesignSystem.lineHeightNormal,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// تجهيز قائمة الإجراءات مع هوامش متسقة
  List<Widget>? _buildActions() {
    if (actions == null || actions!.isEmpty) {
      return actions;
    }

    return actions!
        .map(
          (action) => Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignSystem.sm),
            child: action,
          ),
        )
        .toList();
  }

  @override
  Size get preferredSize {
    final baseHeight = DesignSystem.getResponsiveHeight(8);
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(baseHeight + bottomHeight);
  }
}