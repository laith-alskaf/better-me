import 'package:flutter/material.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';

/// أنماط الأزرار المختلفة
enum ButtonStyle { solid, outline, text, gradient }

/// AppButton - زر موحد مع أنماط متعددة
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonStyle style;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final IconData? icon;
  final MainAxisAlignment mainAxisAlignment;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.style = ButtonStyle.solid,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.icon,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = width ?? screenSize.width * 0.8;
    final buttonHeight = height ?? DesignSystem.buttonHeightBase;
    final buttonRadius = borderRadius ?? DesignSystem.radiusBase;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: _buildButton(buttonRadius),
    );
  }

  Widget _buildButton(double radius) {
    final textColor = foregroundColor ?? Colors.white;
    final bgColor = backgroundColor ?? AppColors.primary;

    if (!isEnabled || isLoading) {
      return _buildDisabledButton(radius, bgColor, textColor);
    }

    switch (style) {
      case ButtonStyle.solid:
        return _buildSolidButton(radius, bgColor, textColor);
      case ButtonStyle.outline:
        return _buildOutlineButton(radius, bgColor, textColor);
      case ButtonStyle.text:
        return _buildTextButton(radius, bgColor, textColor);
      case ButtonStyle.gradient:
        return _buildGradientButton(radius, textColor);
    }
  }

  Widget _buildSolidButton(double radius, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: DesignSystem.elevationMedium,
        padding: EdgeInsets.symmetric(
          horizontal: DesignSystem.base,
          vertical: DesignSystem.sm,
        ),
      ),
      child: _buildButtonContent(textColor),
    );
  }

  Widget _buildOutlineButton(double radius, Color bgColor, Color textColor) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: bgColor,
        side: BorderSide(color: bgColor, width: DesignSystem.borderWidthBase),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: DesignSystem.base,
          vertical: DesignSystem.sm,
        ),
      ),
      child: _buildButtonContent(bgColor),
    );
  }

  Widget _buildTextButton(double radius, Color bgColor, Color textColor) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: DesignSystem.base,
          vertical: DesignSystem.sm,
        ),
      ),
      child: _buildButtonContent(bgColor),
    );
  }

  Widget _buildGradientButton(double radius, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: DesignSystem.shadowElevation4,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(radius),
          child: Center(
            child: _buildButtonContent(textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledButton(double radius, Color bgColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor.withOpacity(DesignSystem.opacityDisabled),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor.withOpacity(DesignSystem.opacityHint),
                  ),
                  strokeWidth: 2,
                ),
              )
            : _buildButtonContent(textColor),
      ),
    );
  }

  Widget _buildButtonContent(Color textColor) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: DesignSystem.iconSm, color: textColor),
          SizedBox(width: DesignSystem.sm),
        ],
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
