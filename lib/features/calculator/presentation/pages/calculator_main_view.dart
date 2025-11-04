import 'package:get/get.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../controllers/calculator_controller.dart';
import '../theme/calculator_colors.dart';
import 'bmi_view.dart';
import 'calories_view.dart';
import 'perfect_weight_view.dart';
import 'blood_pressure_view.dart';
import 'water_body_view.dart';
import 'fat_eating_view.dart';
import 'smoking_cost_view.dart';
import 'package:flutter/material.dart';

/// CalculatorMainView - Unified calculator hub
/// Clean, responsive design with muted colors matching home page
class CalculatorMainView extends GetView<CalculatorController> {
  const CalculatorMainView({super.key});

  // Calculator data - single source of truth
  static final List<Map<String, dynamic>> _calculators = [
    {
      'title': 'BMI Calculator',
      'desc': 'Calculate your Body Mass Index',
      'icon': Icons.scale,
      'color': CalculatorColors.bmiColor,
      'viewBuilder': () => const BMIView(),
    },
    {
      'title': 'Calories Calculator',
      'desc': 'Daily calorie intake estimate',
      'icon': Icons.restaurant,
      'color': CalculatorColors.caloriesColor,
      'viewBuilder': () => const CaloriesView(),
    },
    {
      'title': 'Perfect Weight',
      'desc': 'Your ideal weight range',
      'icon': Icons.balance,
      'color': CalculatorColors.perfectWeightColor,
      'viewBuilder': () => const PerfectWeightView(),
    },
    {
      'title': 'Blood Pressure',
      'desc': 'BP classification checker',
      'icon': Icons.favorite,
      'color': CalculatorColors.bloodPressureColor,
      'viewBuilder': () => const BloodPressureView(),
    },
    {
      'title': 'Water Need',
      'desc': 'Daily hydration requirement',
      'icon': Icons.water_drop,
      'color': CalculatorColors.waterColor,
      'viewBuilder': () => const WaterBodyView(),
    },
    {
      'title': 'Fat Eating',
      'desc': 'Daily fat consumption limit',
      'icon': Icons.warning_rounded,
      'color': CalculatorColors.fatEatingColor,
      'viewBuilder': () => const FatEatingView(),
    },
    {
      'title': 'Smoking Cost',
      'desc': 'Financial impact tracker',
      'icon': Icons.smoke_free,
      'color': CalculatorColors.smokingColor,
      'viewBuilder': () => const SmokingCostView(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Header section
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.04),
                    AppColors.secondary.withValues(alpha: 0.02),
                  ],
                ),
              ),
              padding: EdgeInsets.all(DesignSystem.base.toDouble()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: DesignSystem.sm.toDouble()),
                  const AppText(
                    'Health Calculators',
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.0),
                  const AppText(
                    'Calculate metrics to improve your health',
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),

            // Calculators list
            Padding(
              padding: EdgeInsets.all(DesignSystem.base.toDouble()),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _calculators.length,
                separatorBuilder: (_, __) => SizedBox(height: DesignSystem.md.toDouble()),
                itemBuilder: (context, index) {
                  final calc = _calculators[index];
                  return _buildCalculatorCard(
                    title: calc['title'],
                    desc: calc['desc'],
                    color: calc['color'],
                    icon: calc['icon'],
                    onTap: () => Get.to(calc['viewBuilder']()),
                  );
                },
              ),
            ),

            SizedBox(height: DesignSystem.xl.toDouble()),
          ],
        ),
      ),
    );
  }

  /// Build calculator card - responsive and clean
  Widget _buildCalculatorCard({
    required String title,
    required String desc,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: EdgeInsets.all(DesignSystem.md.toDouble()),
        child: Row(
          children: [
            // Icon container
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
              ),
              child: Icon(
                icon,
                color: color,
                size: DesignSystem.iconMd,
              ),
            ),
            SizedBox(width: DesignSystem.md.toDouble()),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  AppText(
                    desc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow indicator
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: color.withValues(alpha: 0.6),
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}