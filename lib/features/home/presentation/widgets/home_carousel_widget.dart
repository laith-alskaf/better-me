import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'home_carousel_item_widget.dart';
import '../controllers/home_controller.dart';

/// Carousel widget for displaying news/health images
/// عرض شرائح للصور الخاصة بأخبار الصحة مع عنوان وتصميم محسّن
class HomeCarouselWidget extends GetView<HomeController> {
  final int itemCount;
  final ScrollController? scrollController;
  final bool autoScroll;

  const HomeCarouselWidget({
    Key? key,
    this.itemCount = 3,
    this.scrollController,
    this.autoScroll = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with title - تصميم هادئ ومريح
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DesignSystem.base),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(DesignSystem.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius:
                            BorderRadius.circular(DesignSystem.radiusMd),
                      ),
                      child: Icon(
                        Icons.newspaper,
                        color: AppColors.primary.withOpacity(0.7),
                        size: DesignSystem.iconMd,
                      ),
                    ),
                    SizedBox(width: DesignSystem.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'trending'.tr,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          AppText(
                            'health_tips'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: DesignSystem.md),
              // Indicator dots - لون أهدأ
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DesignSystem.base,
                  vertical: DesignSystem.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(DesignSystem.radiusXl),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: AppText(
                  '${itemCount} slides',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: DesignSystem.xl),

        // Carousel cards
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DesignSystem.base),
          child: SizedBox(
            height: 30.h,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: itemCount,
              addAutomaticKeepAlives: true,
              itemBuilder: (BuildContext context, int index) {
                return HomeCarouselItemWidget(
                  imagePath:
                      'images/pic${controller.randomImageIndex[index]}.jpg',
                  onTap: () => _onCarouselItemTap(context, index),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Handle carousel item tap
  void _onCarouselItemTap(BuildContext context, int index) {
    // TODO: Implement navigation or preview logic
    // يمكن إضافة منطق للتنقل أو عرض معاينة الصورة
    debugPrint('Carousel item $index tapped');
  }
}