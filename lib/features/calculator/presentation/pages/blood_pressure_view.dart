import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/calculator_colors.dart';
import '../utils/calculator_functions.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_base_view.dart';
import '../widgets/calculator_input_field.dart';

/// Blood Pressure Calculator View - Refactored with unified design
class BloodPressureView extends GetView<CalculatorController> {
  const BloodPressureView({super.key});

  @override
  Widget build(BuildContext context) {
    final systolicController = TextEditingController();
    final diastolicController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: CalculatorBaseView(
        backgroundColorAppBar: CalculatorColors.bloodPressureAppBarColor,
        title: 'blood_pressure'.tr,
        accentColor: CalculatorColors.bloodPressureColor,
        description: 'check_bp_classification'.tr,
        inputFields: [
          // Systolic field
          CalculatorInputField(
            label: 'systolic'.tr,
            controller: systolicController,
            icon: Icons.favorite,
            accentColor: CalculatorColors.bloodPressureColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'enter_systolic'.tr;
              try {
                double.parse(value!);
              } catch (_) {
                return 'enter_valid_number'.tr;
              }
              return null;
            },
          ),
          // Diastolic field
          CalculatorInputField(
            label: 'diastolic'.tr,
            controller: diastolicController,
            icon: Icons.favorite,
            accentColor: CalculatorColors.bloodPressureColor,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'enter_diastolic'.tr;
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
              double systolic = double.parse(systolicController.text);
              double diastolic = double.parse(diastolicController.text);

              String status = bloodPressureState(systolic, diastolic);
              controller.updateBloodPressure(status);

              AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                animType: AnimType.rightSlide,
                title: 'bp_status'.tr,
                desc: status,
                btnOkColor: CalculatorColors.bloodPressureAppBarColor,
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