import 'package:flutter/material.dart';

/// CustomView Widget - Deprecated
/// Empty container, use CalculatorBaseView instead for better structure
@Deprecated('Use CalculatorBaseView instead')
class CustomView extends StatelessWidget {
  final Widget child;

  const CustomView({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}