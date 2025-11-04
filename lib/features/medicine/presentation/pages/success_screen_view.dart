import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessScreenView extends StatefulWidget {
  const SuccessScreenView({super.key});

  @override
  State<SuccessScreenView> createState() => _SuccessScreenViewState();
}

class _SuccessScreenViewState extends State<SuccessScreenView> {
  @override
  void initState() {
    super.initState();
    // After 2 seconds, go back to medicine list page
    Timer(const Duration(seconds: 2), () {
      // Remove all previous screens and go back to medicine list
      Get.until((route) => route.settings.name == '/medicine');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Lottie.asset('images/assets/animations/animation_success.json'),
      ),
    );
  }
}