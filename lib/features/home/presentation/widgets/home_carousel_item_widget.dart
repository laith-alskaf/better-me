import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:sizer/sizer.dart';

/// Carousel item widget - single image card in carousel with animation
/// عنصر الصورة في عرض الشرائح مع animation عند الضغط
class HomeCarouselItemWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool showGradient;

  const HomeCarouselItemWidget({
    Key? key,
    required this.imagePath,
    this.onTap,
    this.width,
    this.height,
    this.showGradient = true,
  }) : super(key: key);

  @override
  State<HomeCarouselItemWidget> createState() =>
      _HomeCarouselItemWidgetState();
}

class _HomeCarouselItemWidgetState extends State<HomeCarouselItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: DesignSystem.sm),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: widget.width ?? 80.w,
            height: widget.height ?? 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
              image: DecorationImage(
                image: AssetImage(widget.imagePath),
                fit: BoxFit.cover,
              ),
              boxShadow: DesignSystem.shadowElevation8,
              border: Border.all(
                color: AppColors.primary.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: widget.showGradient
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(DesignSystem.radiusMd),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Badge at top-right
                        Positioned(
                          top: DesignSystem.md,
                          right: DesignSystem.md,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: DesignSystem.sm,
                              vertical: DesignSystem.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(
                                DesignSystem.radiusSm,
                              ),
                            ),
                            child: Text(
                              'Featured',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Call to action at bottom
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(DesignSystem.base),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: DesignSystem.md,
                                vertical: DesignSystem.sm,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(
                                  DesignSystem.radiusSm,
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Icon(
                                    Icons.touch_app_rounded,
                                    color: Colors.white.withOpacity(0.9),
                                    size: DesignSystem.iconSm,
                                  ),
                                  SizedBox(width: DesignSystem.sm),
                                  Text(
                                    'tap_to_learn_more'.tr,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}