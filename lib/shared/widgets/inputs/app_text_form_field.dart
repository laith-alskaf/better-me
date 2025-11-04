import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/localization/localization_controller.dart';

/// AppTextFormField - حقل إدخال نصي موحد وقابل للتخصيص
class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? errorBorderColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool enableBorder;

  const AppTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.backgroundColor,
    this.borderColor,
    this.errorBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.style,
    this.hintStyle,
    this.enableBorder = true,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late FocusNode _focusNode;
  bool _obscured = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _obscured = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = LocalizationController.instance.isArabic;

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscured,
      readOnly: widget.readOnly,
      maxLines: _obscured ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: _focusNode,
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      style: widget.style ??
          const TextStyle(
            fontSize: 16,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w400,
          ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ??
            (widget.obscureText
                ? GestureDetector(
                    onTap: () {
                      setState(() => _obscured = !_obscured);
                    },
                    child: Icon(
                      _obscured ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textLight,
                      size: DesignSystem.iconMd,
                    ),
                  )
                : null),
        contentPadding: widget.contentPadding ??
           const  EdgeInsets.symmetric(
              horizontal: DesignSystem.base,
              vertical: DesignSystem.md,
            ),
        filled: true,
        fillColor: widget.backgroundColor ?? AppColors.background,
        hintStyle: widget.hintStyle ??
            TextStyle(
              color: AppColors.textLight.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
        border: _buildBorder(widget.borderColor),
        enabledBorder: _buildBorder(widget.borderColor),
        focusedBorder: _buildBorder(AppColors.primary),
        errorBorder: _buildBorder(widget.errorBorderColor ?? Colors.red),
        focusedErrorBorder: _buildBorder(Colors.red),
        errorStyle: TextStyle(
          color: widget.errorBorderColor ?? Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color? color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? DesignSystem.radiusMd,
      ),
      borderSide: BorderSide(
        color: widget.enableBorder
            ? (color ?? AppColors.textLight.withOpacity(0.2))
            : Colors.transparent,
        width: DesignSystem.borderWidthBase,
      ),
    );
  }
}
