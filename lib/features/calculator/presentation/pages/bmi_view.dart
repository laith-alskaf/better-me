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

/// BMI Calculator View - Refactored with unified design
class BMIView extends GetView<CalculatorController> {
  const BMIView({super.key});

  @override
  Widget build(BuildContext context) {
    final weightController = TextEditingController();
    final heightController = TextEditingController();
    final ageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: CalculatorBaseView(
        backgroundColorAppBar:CalculatorColors.bmiColor ,
        title: 'BMI Calculator',
        accentColor: CalculatorColors.bmiColor,
        description: 'Calculate your Body Mass Index',
        inputFields: [
          // Age field
          CalculatorInputField(
            label: 'Age',
            controller: ageController,
            icon: Icons.cake_rounded,
            accentColor: CalculatorColors.bmiColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Enter age';
              try {
                if (double.parse(value!) > 110) return 'Please enter valid age';
              } catch (_) {
                return 'Enter a valid number';
              }
              return null;
            },
          ),
          // Weight field
          CalculatorInputField(
            label: 'Weight (kg)',
            controller: weightController,
            icon: Icons.balance,
            accentColor: CalculatorColors.bmiColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Enter weight';
              try {
                double.parse(value!);
              } catch (_) {
                return 'Enter a valid number';
              }
              return null;
            },
          ),
          // Height field
          CalculatorInputField(
            label: 'Height (cm)',
            controller: heightController,
            icon: Icons.height,
            accentColor: CalculatorColors.bmiColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Enter height';
              try {
                if (double.parse(value!) > 250)
                  return 'Please enter valid height';
              } catch (_) {
                return 'Enter a valid number';
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
                    'Gender',
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
                          'Male',
                          'male',
                          Icons.male,
                          controller.selectedGender.value,
                          (val) => controller.updateGender(val),
                        ),
                      ),
                      SizedBox(width: DesignSystem.md.toDouble()),
                      Expanded(
                        child: _buildGenderOption(
                          'Female',
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
              double weight = double.parse(weightController.text);
              double height = double.parse(heightController.text) / 100;
              double bmi = weight / (height * height);

              var result = checkBMIState(bmi);
              controller.updateBMI(bmi);

              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: 'Your BMI',
                desc: '${bmi.toStringAsFixed(1)}\n${result[0]}',
                descTextStyle:
                    TextStyle(color: result[1], fontSize: 16.sp),
                btnOkColor: result[1],
                btnOkOnPress: () {},
              ).show();
            } catch (e) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.leftSlide,
                title: 'Error',
                desc: 'Please enter valid values',
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
    final color = CalculatorColors.bmiColor;

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