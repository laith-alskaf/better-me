import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import '../theme/calculator_colors.dart';

/// CalculatorInputField - Unified input field for calculator screens
/// Provides consistent styling and validation
class CalculatorInputField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? icon;
  final Color? accentColor;

  const CalculatorInputField({
    Key? key,
    required this.label,
    required this.controller,
    this.hint,
    this.validator,
    this.keyboardType = TextInputType.number,
    this.icon,
    this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? CalculatorColors.bloodPressureColor;
    final mutedColor = color.withOpacity(0.5);

    return Padding(
      padding: EdgeInsets.only(bottom: DesignSystem.sm.toDouble()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          AppText(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: CalculatorColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.0),

          // Input field with icon
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: mutedColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                  ),
                  child: Icon(
                    icon,
                    color: mutedColor,
                    size: DesignSystem.iconMd,
                  ),
                ),
                SizedBox(width: DesignSystem.md),
              ],
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  validator: validator,
                  decoration: InputDecoration(
                    hintText: hint ?? label,
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: CalculatorColors.textLight,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                      borderSide: BorderSide(
                        color: CalculatorColors.inputBorder,
                        width: 0.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                      borderSide: BorderSide(
                        color: CalculatorColors.inputBorder,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                      borderSide: BorderSide(
                        color: mutedColor,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                      borderSide: BorderSide(
                        color: Colors.red.withOpacity(0.5),
                        width: 0.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: DesignSystem.md.toDouble(),
                      vertical: DesignSystem.sm.toDouble(),
                    ),
                    errorStyle: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.red.withOpacity(0.8),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: CalculatorColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}