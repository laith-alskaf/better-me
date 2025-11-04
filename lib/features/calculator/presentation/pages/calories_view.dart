import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import '../theme/calculator_colors.dart';
import '../utils/calculator_functions.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_base_view.dart';
import '../widgets/calculator_input_field.dart';

/// Calories Calculator View - Refactored with unified design
class CaloriesView extends GetView<CalculatorController> {
  const CaloriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final ageController = TextEditingController();
    final heightController = TextEditingController();
    final weightController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: CalculatorBaseView(
          backgroundColorAppBar: CalculatorColors.caloriesAppBarColor,
          title: 'calories_calculator'.tr,
          accentColor: CalculatorColors.caloriesColor,
          description: 'calculate_calories'.tr,
          inputFields: [
            // Age field
            CalculatorInputField(
              label: 'age'.tr,
              controller: ageController,
              icon: Icons.cake_rounded,
              accentColor: CalculatorColors.caloriesColor,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'enter_age'.tr;
                try {
                  if (double.parse(value!) > 110) return 'enter_valid_age'.tr;
                } catch (_) {
                  return 'enter_valid_number'.tr;
                }
                return null;
              },
            ),
            // Height field
            CalculatorInputField(
              label: 'height'.tr,
              controller: heightController,
              icon: Icons.height,
              accentColor: CalculatorColors.caloriesColor,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'enter_height'.tr;
                try {
                  if (double.parse(value!) > 250) return 'enter_valid_height'.tr;
                } catch (_) {
                  return 'enter_valid_number'.tr;
                }
                return null;
              },
            ),
            // Weight field
            CalculatorInputField(
              label: 'weight'.tr,
              controller: weightController,
              icon: Icons.balance,
              accentColor: CalculatorColors.caloriesColor,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'enter_weight'.tr;
                try {
                  double.parse(value!);
                } catch (_) {
                  return 'enter_valid_number'.tr;
                }
                return null;
              },
            ),
            // Activity level selection
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(vertical: DesignSystem.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'activity_level'.tr,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: CalculatorColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Column(
                      children: [
                        _buildActivityOption(
                          'activity_sedentary'.tr,
                          'sedentary',
                          CalculatorColors.caloriesColor,
                        ),
                        SizedBox(height: 8.0),
                        _buildActivityOption(
                          'activity_light'.tr,
                          'light',
                          CalculatorColors.caloriesColor,
                        ),
                        SizedBox(height: 8.0),
                        _buildActivityOption(
                          'activity_moderate'.tr,
                          'moderate',
                          CalculatorColors.caloriesColor,
                        ),
                        SizedBox(height: 8.0),
                        _buildActivityOption(
                          'activity_high'.tr,
                          'high',
                          CalculatorColors.caloriesColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          onCalculate: () {
            if (formKey.currentState?.validate() ?? false) {
              try {
                double age = double.parse(ageController.text);
                double height = double.parse(heightController.text);
                double weight = double.parse(weightController.text);

                double bmr = calcBMR(height, age, weight, 'male');
                
                // Map activity level to old format
                String trainingLevel = _mapActivityLevel();
                double calories = calcCaloriesNeed(bmr, trainingLevel);

                controller.updateCaloriesNeed(calories);

                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'daily_calories'.tr,
                  desc: '${calories.toStringAsFixed(0)} ${'calories'.tr}',
                  btnOkColor: CalculatorColors.caloriesAppBarColor,
                  btnOkOnPress: () {},
                ).show();
              } catch (e) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.leftSlide,
                  title: 'error'.tr,
                  desc: 'enter_valid_values'.tr,
                ).show();
              }
            }
          },
        ),
      
    );
  }

  /// Build activity level option
  Widget _buildActivityOption(
    String label,
    String value,
    Color color,
  ) {
    final isSelected = controller.selectedActivityLevel.value == value;

    return GestureDetector(
      onTap: () => controller.selectedActivityLevel.value = value,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: DesignSystem.md.toDouble(),
          horizontal: DesignSystem.sm.toDouble(),
        ),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
          border: Border.all(
            color: isSelected ? color : color.withValues(alpha: 0.2),
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : CalculatorColors.textLight,
                  width: 2,
                ),
                color: isSelected ? color : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: AppText(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? color : CalculatorColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Map activity level to old format for calculation
  String _mapActivityLevel() {
    final level = controller.selectedActivityLevel.value;
    switch (level) {
      case 'light':
        return 'normal training 1-3 day';
      case 'moderate':
        return 'hard training 3-5 day';
      case 'high':
        return 'very hard training 6-7 day';
      default:
        return 'less training 1-2 day';
    }
  }
}