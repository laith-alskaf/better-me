import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_header_widget.dart';
import '../widgets/home_carousel_widget.dart';
import '../widgets/home_tips_widget.dart';
import '../widgets/quick_stats_widget.dart';

/// HomeView - الصفحة الرئيسية
/// تعرض:
/// - AppBar موحد مع تحية ديناميكية
/// - إحصائيات سريعة
/// - عرض شرائح الأخبار الصحية
/// - نصائح صحية مرتبة بتصميم محسّن
class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gradient background header section - تصميم هادئ ومريح
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.04),
                    AppColors.secondary.withOpacity(0.02),
                  ],
                ),
              ),
              child:const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Welcome header
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      DesignSystem.base,
                      DesignSystem.xl,
                      DesignSystem.base,
                      DesignSystem.base,
                    ),
                    child: HomeHeaderWidget(
                      textColor: AppColors.textPrimary,
                      showDivider: false,
                    ),
                  ),

                  // Quick Stats Cards - مع تباعد مناسب
                   Padding(
                    padding: EdgeInsets.all(
                      DesignSystem.base,
                    ),
                    child:  QuickStatsWidget(),
                  ),

                  SizedBox(height: DesignSystem.md),
                ],
              ),
            ),

            // Spacer - تباعد منظم
            const SizedBox(height: DesignSystem.lg),

            // Carousel section - Health News
            HomeCarouselWidget(
              itemCount: 3,
              scrollController: controller.scrollController,
              autoScroll: true,
            ),

            // Spacer - تباعد معقول
            const SizedBox(height: DesignSystem.lg),

            // Health tips section - منظمة ومريحة للعين
           const  HomeHealthTipsWidget(
              showDivider: true,
              padding: EdgeInsets.only(
                left: DesignSystem.base,
                right: DesignSystem.base,
                bottom: DesignSystem.base,
              ),
            ),
          ],
        ),
      );
   
  }
}
