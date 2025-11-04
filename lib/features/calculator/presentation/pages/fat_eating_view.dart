import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/calculator_colors.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_base_view.dart';
import '../widgets/calculator_input_field.dart';

/// Fat Eating Calculator View - Refactored with unified design
class FatEatingView extends GetView<CalculatorController> {
  const FatEatingView({super.key});

  @override
  Widget build(BuildContext context) {
    final weightController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: CalculatorBaseView(
        backgroundColorAppBar: CalculatorColors.fatEatingAppBarColor,
        title: 'fat_eating'.tr,
        accentColor: CalculatorColors.fatEatingColor,
        description: 'daily_fat_limit'.tr,
        inputFields: [
          // Weight field
          CalculatorInputField(
            label: 'weight'.tr,
            controller: weightController,
            icon: Icons.balance,
            accentColor: CalculatorColors.fatEatingColor,
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
        ],
        onCalculate: () {
          if (formKey.currentState?.validate() ?? false) {
            try {
              double weight = double.parse(weightController.text);
              // Fat limit is typically 1g per kg of body weight (WHO recommendation)
              double fatLimit = weight * 1.0;

              controller.updateFatEating(fatLimit);

              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: 'daily_fat_limit'.tr,
                desc: '${fatLimit.toStringAsFixed(1)} ${'grams'.tr}',
                btnOkColor: CalculatorColors.fatEatingAppBarColor,
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
}