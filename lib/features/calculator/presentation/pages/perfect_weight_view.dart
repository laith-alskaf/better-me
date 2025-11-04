import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/calculator_colors.dart';
import '../utils/calculator_functions.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_base_view.dart';
import '../widgets/calculator_input_field.dart';

/// Perfect Weight Calculator View - Refactored with unified design
class PerfectWeightView extends GetView<CalculatorController> {
  const PerfectWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    final heightController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: CalculatorBaseView(
        backgroundColorAppBar: CalculatorColors.perfectWeightAppBarColor,
        title: 'perfect_weight'.tr,
        accentColor: CalculatorColors.perfectWeightColor,
        description: 'calculate_ideal_weight'.tr,
        inputFields: [
          // Height field
          CalculatorInputField(
            label: 'height'.tr,
            controller: heightController,
            icon: Icons.height,
            accentColor: CalculatorColors.perfectWeightColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'enter_height'.tr;
              try {
                if (double.parse(value!) > 250)
                  return 'enter_valid_height'.tr;
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
              double height = double.parse(heightController.text);
              double weight = perfectWeight(height);

              controller.updatePerfectWeight(weight);

              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: 'your_perfect_weight'.tr,
                desc: '${weight.toStringAsFixed(1)} ${'kg'.tr}',
                btnOkColor: CalculatorColors.perfectWeightAppBarColor,
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