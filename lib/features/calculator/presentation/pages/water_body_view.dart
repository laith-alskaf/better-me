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

/// Water Need Calculator View - Refactored with unified design
class WaterBodyView extends GetView<CalculatorController> {
  const WaterBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    final ageController = TextEditingController();
    final weightController = TextEditingController();
    final heightController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child:CalculatorBaseView(
          backgroundColorAppBar: CalculatorColors.waterAppBarColor,
          title: 'water_need'.tr,
          accentColor: CalculatorColors.waterColor,
          description: 'calculate_daily_water'.tr,
          inputFields: [
            // Age field
            CalculatorInputField(
              label: 'age'.tr,
              controller: ageController,
              icon: Icons.cake_rounded,
              accentColor: CalculatorColors.waterColor,
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
            // Weight field
            CalculatorInputField(
              label: 'weight'.tr,
              controller: weightController,
              icon: Icons.balance,
              accentColor: CalculatorColors.waterColor,
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
            // Height field
            CalculatorInputField(
              label: 'height'.tr,
              controller: heightController,
              icon: Icons.height,
              accentColor: CalculatorColors.waterColor,
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
            // Gender selection
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(vertical: DesignSystem.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'gender'.tr,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: CalculatorColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: _buildGenderOption(
                            'male'.tr,
                            'male',
                            Icons.male,
                            controller.selectedGender.value,
                            (val) => controller.updateGender(val),
                          ),
                        ),
                        SizedBox(width: DesignSystem.md.toDouble()),
                        Expanded(
                          child: _buildGenderOption(
                            'female'.tr,
                            'female',
                            Icons.female,
                            controller.selectedGender.value,
                            (val) => controller.updateGender(val),
                          ),
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
                double weight = double.parse(weightController.text);
                double height = double.parse(heightController.text);

                double waterNeed = waterInBody(age, weight, height, controller.selectedGender.value);
                controller.updateWaterNeed(waterNeed);

                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'daily_water_need'.tr,
                  desc: '${waterNeed.toStringAsFixed(1)} ${'liters'.tr}',
                  btnOkColor: CalculatorColors.waterAppBarColor,
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

  /// Gender option widget
  Widget _buildGenderOption(
    String label,
    String value,
    IconData icon,
    String selectedValue,
    Function(String) onChanged,
  ) {
    final isSelected = selectedValue == value;
    final color = CalculatorColors.waterColor;

    return GestureDetector(
      onTap: () => onChanged(value),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : CalculatorColors.textLight,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            AppText(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? color : CalculatorColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}