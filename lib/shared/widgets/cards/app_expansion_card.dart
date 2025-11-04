import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/localization/localization_controller.dart';
import 'package:BetterMe/shared/widgets/common/app_divider.dart';

/// AppExpansionCard - بطاقة قابلة للتوسع (مناسبة للـ FAQ)
class AppExpansionCard extends StatefulWidget {
  final String title;
  final String content;
  final bool initiallyExpanded;
  final VoidCallback? onExpanded;
  final VoidCallback? onCollapsed;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? contentColor;

  const AppExpansionCard({
    Key? key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
    this.onExpanded,
    this.onCollapsed,
    this.backgroundColor,
    this.titleColor,
    this.contentColor,
  }) : super(key: key);

  @override
  State<AppExpansionCard> createState() => _AppExpansionCardState();
}

class _AppExpansionCardState extends State<AppExpansionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _animationController = AnimationController(
      duration: DesignSystem.animationDurationNormal,
      vsync: this,
      value: _isExpanded ? 1.0 : 0.0,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
      widget.onExpanded?.call();
    } else {
      _animationController.reverse();
      widget.onCollapsed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = LocalizationController.instance.isArabic;

    return Container(
      margin: EdgeInsets.symmetric(vertical: DesignSystem.sm),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.background,
        borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
        border: Border.all(
          color: AppColors.textLight.withOpacity(0.2),
          width: DesignSystem.borderWidthBase,
        ),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _toggleExpanded,
              borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
              child: Padding(
                padding: EdgeInsets.all(DesignSystem.base),
                child: Row(
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.titleColor ?? AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                      ),
                    ),
                    SizedBox(width: DesignSystem.md),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5)
                          .animate(_animationController),
                      child: Icon(
                        isArabic ? Icons.chevron_left : Icons.chevron_right,
                        color: AppColors.primary,
                        size: DesignSystem.iconBase,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ClipRect(
            child: SizeTransition(
              sizeFactor: _animationController,
              axisAlignment: -1,
              child: Padding(
                padding: EdgeInsets.only(
                  left: DesignSystem.base,
                  right: DesignSystem.base,
                  bottom: DesignSystem.base,
                ),
                child: Column(
                  children: [
                    AppDivider(
                      margin: EdgeInsets.only(bottom: DesignSystem.base),
                    ),
                    Text(
                      widget.content,
                      style: TextStyle(
                        color: widget.contentColor ??
                            AppColors.textLight.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: DesignSystem.lineHeightRelaxed,
                      ),
                      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// استيراد مساعد
