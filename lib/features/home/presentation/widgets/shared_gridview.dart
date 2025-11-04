import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:sizer/sizer.dart';

/// SharedGridviewWidget
/// Reusable expandable gridview item with animation and modern design
/// متجاوب مع أحجام الموبايل - عرض كامل النصيحة عند الضغط
class SharedGridview extends StatefulWidget {
  final String text;
  final Widget listOfText;
  final IconData? icon;
  final Color? accentColor;

  const SharedGridview({
    Key? key,
    required this.text,
    required this.listOfText,
    this.icon,
    this.accentColor,
  }) : super(key: key);

  @override
  State<SharedGridview> createState() => _SharedGridviewState();
}

class _SharedGridviewState extends State<SharedGridview>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: DesignSystem.animationDurationSlow,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // استخدام لون أهدأ وأقل تشبعاً
    final accentColor = widget.accentColor ?? AppColors.primary;
    final mutedAccentColor = accentColor.withOpacity(0.5);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DesignSystem.sm,
        horizontal: DesignSystem.xs,
      ),
      child: AnimatedSize(
        duration: DesignSystem.animationDurationSlow,
        reverseDuration: DesignSystem.animationDurationSlow,
        curve: DesignSystem.curveEaseInOut,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
                border: Border.all(
                  color: mutedAccentColor.withOpacity(0.2),
                  width: DesignSystem.borderWidthBase,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: isExpanded ? 12 : 8,
                    offset: Offset(0, isExpanded ? 4 : 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(DesignSystem.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header - Title and Icon
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Expand/Collapse Icon مع سلاسة
                        AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: DesignSystem.animationDurationSlow,
                          child: Icon(
                            Icons.expand_more_rounded,
                            size: DesignSystem.iconBase,
                            color: mutedAccentColor,
                          ),
                        ),
                        // Title and custom icon
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: DesignSystem.md,
                            ),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (widget.icon != null) ...[
                                  Container(
                                    padding: EdgeInsets.all(DesignSystem.sm.sp),
                                    decoration: BoxDecoration(
                                      color: mutedAccentColor.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(
                                        DesignSystem.radiusMd,
                                      ),
                                    ),
                                    child: Icon(
                                      widget.icon,
                                      color: mutedAccentColor,
                                      size: DesignSystem.iconMd,
                                    ),
                                  ),
                                  const SizedBox(width: DesignSystem.md),
                                ],
                                Expanded(
                                  child: Text(
                                    widget.text,
                                    textDirection: TextDirection.rtl,
                                    maxLines: isExpanded ? null : 2,
                                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: DesignSystem.bodyMedium.fontSize,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                      height: DesignSystem.lineHeightTight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Expanded content - عرض كامل النصيحة
                    if (isExpanded) ...[
                      const SizedBox(height: DesignSystem.md),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(DesignSystem.md),
                        decoration: BoxDecoration(
                          color: mutedAccentColor.withOpacity(0.03),
                          borderRadius:
                              BorderRadius.circular(DesignSystem.radiusSm),
                          border: Border.all(
                            color: mutedAccentColor.withOpacity(0.08),
                            width: DesignSystem.borderWidthThin,
                          ),
                        ),
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: DesignSystem.bodySmall.fontSize,
                            color: AppColors.textSecondary,
                            height: DesignSystem.lineHeightRelaxed,
                            fontWeight: FontWeight.w400,
                          ),
                          child: SingleChildScrollView(
                            child: widget.listOfText,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}