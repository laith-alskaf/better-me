import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldSIgnUP extends StatelessWidget {
  final FocusNode? firstNameFocus;
  final FocusNode? lastNameFocus;
  final String hintText;
  final TextStyle? hintTextStyle;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final Widget? prefixIcon;
  final double? contentPadding;
  final TextInputType? textInputType;
  final bool? obscureTextBollean;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;

  // GlobalKey<FormState>? formstate;
  const TextFormFieldSIgnUP({
    Key? key,
    required this.hintText,
    this.controller,
    this.validator,
    this.firstNameFocus,
    this.lastNameFocus,
    this.paddingHorizontal,
    this.paddingVertical,
    this.prefixIcon,
    this.contentPadding,
    this.obscureTextBollean,
    this.hintTextStyle,
    this.textInputType,
    this.readOnly=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? 20, horizontal: paddingHorizontal ?? 20),
      child: TextFormField(
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: obscureTextBollean ?? false,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(lastNameFocus);
        },
        focusNode: firstNameFocus,
        readOnly: readOnly!,
        // enableInteractiveSelection: true,
        // autofocus: true,
        validator: validator,
        // autovalidateMode: AutovalidateMode.always,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: contentPadding ?? size.width * 0.1),
            filled: true,
            prefixIcon: prefixIcon,
            fillColor: Colors.black38,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            hintText: hintText,
            hintStyle: hintTextStyle),
      ),
    );
  }
}
