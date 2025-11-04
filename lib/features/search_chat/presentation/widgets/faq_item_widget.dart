import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';

/// FAQItemWidget - بطاقة سؤال وجواب قابلة للتوسع
class FAQItemWidget extends StatefulWidget {
  final String question;
  final String answer;
  final int index;

  const FAQItemWidget({
    super.key,
    required this.question,
    required this.answer,
    this.index = 0,
  });

  @override
  State<FAQItemWidget> createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
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
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.base,
        vertical: DesignSystem.sm,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleExpanded,
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
          child: Container(
            decoration: BoxDecoration(
              color: _isExpanded
                  ? AppColors.primary.withValues(alpha: 0.05)
                  : Colors.white,
              border: Border.all(
                color: _isExpanded
                    ? AppColors.primary
                    : AppColors.outline.withValues(alpha: 0.3),
                width: _isExpanded
                    ? DesignSystem.borderWidthMedium
                    : DesignSystem.borderWidthBase,
              ),
              borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
              boxShadow: _isExpanded ? DesignSystem.shadowElevation4 : [],
            ),
            child: Column(
              children: [
                // Question Header
                Padding(
                  padding: EdgeInsets.all(DesignSystem.base),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Number Badge
                      Container(
                        width: DesignSystem.iconBase,
                        height: DesignSystem.iconBase,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: AppText(
                            '${widget.index + 1}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: DesignSystem.base),
                      // Question Text - يظهر كاملاً بدون قطع
                      Expanded(
                        child: Text(
                          widget.question,
                          softWrap: true,
                          maxLines: null,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(width: DesignSystem.sm),
                      // Expand Icon with Animation
                      RotationTransition(
                        turns: Tween<double>(begin: 0, end: 0.5).animate(
                          CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
                        ),
                        child: Icon(
                          Icons.expand_more_rounded,
                          color: _isExpanded ? AppColors.primary : AppColors.textSecondary,
                          size: DesignSystem.iconMd,
                        ),
                      ),
                    ],
                  ),
                ),
                // Answer Body (Animated)
                ClipRect(
                  child: SizeTransition(
                    sizeFactor: _animationController,
                    axisAlignment: -1.0,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
                      ),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 1.5,
                              color: AppColors.primary.withValues(alpha: 0.15),
                            ),
                            Padding(
                              padding: EdgeInsets.all(DesignSystem.base),
                              child: Text(
                                widget.answer,
                                softWrap: true,
                                maxLines: null,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                  height: DesignSystem.lineHeightRelaxed,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}