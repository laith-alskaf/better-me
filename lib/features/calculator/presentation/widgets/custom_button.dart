import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/design_system.dart';

/// CustomButton Widget - Deprecated
/// Use AppButton from shared/widgets/index.dart instead
/// Kept for backward compatibility only
@Deprecated('Use AppButton from shared widgets instead')
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          vertical: DesignSystem.md.h,
          horizontal: DesignSystem.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
        ),
      ),
      child: Text(
        "Calculate",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}