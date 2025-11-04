import 'package:get/get.dart';

/// CalculatorController
/// Manages calculator state and calculations
class CalculatorController extends GetxController {
  // BMI
  RxDouble bmi = 0.0.obs;
  RxString bmiStatus = ''.obs;
  RxString selectedGender = 'male'.obs;

  // Calories
  RxDouble bmr = 0.0.obs;
  RxDouble caloriesNeed = 0.0.obs;
  RxString selectedActivityLevel = 'sedentary'.obs;

  // Blood Pressure
  RxString bloodPressureStatus = ''.obs;

  // Water
  RxDouble waterNeed = 0.0.obs;

  // Smoking
  RxDouble monthlyCost = 0.0.obs;

  // Perfect Weight
  RxDouble perfectWeight = 0.0.obs;

  // Fat Eating
  RxDouble fatEating = 0.0.obs;

  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  void updateBMI(double value) {
    bmi.value = value;
  }

  void updateBMR(double value) {
    bmr.value = value;
  }

  void updateCaloriesNeed(double value) {
    caloriesNeed.value = value;
  }

  void updateBloodPressure(String status) {
    bloodPressureStatus.value = status;
  }

  void updateWaterNeed(double value) {
    waterNeed.value = value;
  }

  void updateMonthlyCost(double value) {
    monthlyCost.value = value;
  }

  void updatePerfectWeight(double value) {
    perfectWeight.value = value;
  }

  void updateFatEating(double value) {
    fatEating.value = value;
  }
}