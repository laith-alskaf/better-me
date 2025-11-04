import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/calculator_colors.dart';
import '../utils/calculator_functions.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_base_view.dart';
import '../widgets/calculator_input_field.dart';

/// Smoking Cost Calculator View - Refactored with unified design
class SmokingCostView extends GetView<CalculatorController> {
  const SmokingCostView({super.key});

  @override
  Widget build(BuildContext context) {
    final cigarettesPerDayController = TextEditingController();
    final cigarettesPerPackController = TextEditingController();
    final costPerPackController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: CalculatorBaseView(
        backgroundColorAppBar: CalculatorColors.smokingAppBarColor,
        title: 'smoking_cost'.tr,
        accentColor: CalculatorColors.smokingColor,
        description: 'financial_impact_tracker'.tr,
        inputFields: [
          // Cigarettes per day field
          CalculatorInputField(
            label: 'cigs_per_day'.tr,
            controller: cigarettesPerDayController,
            icon: Icons.smoke_free,
            accentColor: CalculatorColors.smokingColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'enter_cigs_per_day'.tr;
              try {
                double.parse(value!);
              } catch (_) {
                return 'enter_valid_number'.tr;
              }
              return null;
            },
          ),
          // Cigarettes per pack field
          CalculatorInputField(
            label: 'cigs_per_pack'.tr,
            controller: cigarettesPerPackController,
            icon: Icons.smoke_free,
            accentColor: CalculatorColors.smokingColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'enter_cigs_per_pack'.tr;
              try {
                double.parse(value!);
              } catch (_) {
                return 'enter_valid_number'.tr;
              }
              return null;
            },
          ),
          // Cost per pack field
          CalculatorInputField(
            label: 'cost_per_pack'.tr,
            controller: costPerPackController,
            icon: Icons.currency_exchange,
            accentColor: CalculatorColors.smokingColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'enter_cost_per_pack'.tr;
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
              double cigarettes = double.parse(cigarettesPerDayController.text);
              double perPack = double.parse(cigarettesPerPackController.text);
              double cost = double.parse(costPerPackController.text);

              double monthlyCost = smokingCost(cigarettes, perPack, cost);
              controller.updateMonthlyCost(monthlyCost);

              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: 'monthly_smoking_cost'.tr,
                desc: '\$${monthlyCost.toStringAsFixed(2)}',
                btnOkColor: CalculatorColors.smokingAppBarColor,
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