import 'package:flutter/material.dart';
import '../theme/calculator_colors.dart';

/// BMI Calculation Helper
/// Returns [status text, color] for BMI value
List<dynamic> checkBMIState(double bmi) {
  String myString = "Hello, world!";
  Color myColor = Colors.blue;
  List<dynamic> check = [myString, myColor];
  
  if (bmi < 18.5) {
    check[0] = 'تحت الوزن';
    check[1] = CalculatorColors.blue;
  } else if (bmi >= 18.5 && bmi < 25) {
    check[0] = 'وزن طبيعي';
    check[1] = CalculatorColors.lightGreen;
  } else if (bmi >= 25 && bmi < 30) {
    check[0] = 'وزن زائد';
    check[1] = CalculatorColors.lightOrange;
  } else if (bmi >= 30 && bmi < 40) {
    check[0] = 'زيادة كبيرة';
    check[1] = Colors.red.withValues(alpha: 0.8);
  } else {
    check[0] = "زيادة كبيرة جدا";
    check[1] = Colors.red;
  }
  return check;
}

/// Basal Metabolic Rate (BMR) Calculation
/// Calculates daily calorie burn at rest
double calcBMR(double height, double age, double weight, String gender) {
  double bmr = 0;
  if (gender == 'male') {
    bmr = 88.36 + (13.4 * weight) + (4.8 * height) - (age * 5.7);
  } else {
    bmr = 447.6 + (9.4 * weight) + (height * 3.1) - (age * 4.3);
  }
  return bmr;
}

/// Calorie Needs Based on Activity Level
/// Multiplies BMR by activity factor
double calcCaloriesNeed(double bmr, String training) {
  double calories = 0;
  if (training == "less training 1-2 day") {
    calories = bmr * 1.2;
  } else if (training == "normal training 1-3 day") {
    calories = bmr * 1.55;
  } else if (training == "hard training 3-5 day") {
    calories = bmr * 1.725;
  } else {
    calories = bmr * 1.9;
  }
  return calories;
}

/// Blood Pressure State Classification
/// Returns pressure category (low/normal/high)
String bloodPressureState(double systolic, double diastolic) {
  String bloodPressureState = "";
  double calc = (diastolic + (systolic * 2)) / 3;
  
  if (calc < 90) {
    bloodPressureState = 'ضغط منخفض';
  } else if (calc >= 90 && calc <= 119) {
    bloodPressureState = 'ضغط طبيعي';
  } else {
    bloodPressureState = 'ضغط مرتفع';
  }
  return bloodPressureState;
}

/// Blood Volume in Body Calculation
/// Estimated blood volume based on weight, height, and gender
double bloodInBody(double weight, double height, String gender) {
  double bloodInBody = 0;
  if (gender == 'male') {
    bloodInBody = (0.3669 * weight) + (0.03219 * height) + 0.1833;
  } else {
    bloodInBody = (0.3561 * weight) + (0.03308 * height) + 0.1833;
  }
  return bloodInBody;
}

/// Smoking Cost Calculator
/// Calculates monthly cost of smoking
double smokingCost(
    double cigarettesPerDay, double cigarettesPerPack, double costPerPack) {
  double packs = cigarettesPerDay / cigarettesPerPack;
  double dailyCost = packs * costPerPack;
  double monthlyCost = dailyCost * 30;
  return monthlyCost;
}

/// Perfect Weight Calculator
/// BMI-based ideal weight calculation
double perfectWeight(double height) {
  double p = 24 * ((height * height) * 0.0001);
  return p;
}

/// Water Need in Body Calculation
/// Daily water requirement based on personal metrics
double waterInBody(double age, double weight, double height, String gender) {
  double cal = 0;
  if (gender == 'male') {
    cal = (2.447 - (0.09145 * age) + (0.1074 * height) + (0.3362 * weight)) -
        (0.09516);
  } else {
    cal = (2.447 - (0.09145 * age) + (0.1074 * height) + (0.3362 * weight));
  }
  return cal;
}

/// Alternative BMR Calculation Formula
/// Another method for BMR calculation
double calcBMRAlternative(double height, double age, double weight, String gender) {
  double bmr = 0;
  if (gender == 'male') {
    bmr = 66 + (13.7 * weight) + (5 * height) - (age * 6.8);
  } else {
    bmr = 655 + (9.4 * weight) + (height * 9.6) - (age * 4.7);
  }
  return bmr;
}