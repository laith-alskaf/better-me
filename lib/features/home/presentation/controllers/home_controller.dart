import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// HomeController
/// Manages Home view state including carousel animation
class HomeController extends GetxController {
  late ScrollController scrollController;
  late Timer _timer;
  RxInt currentIndex = 0.obs;
  RxList<int> randomImageIndex = RxList<int>([]);

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    _generateUniqueRandomNumbers();
    _startTimer();
  }

  /// Generate 3 unique random numbers for image carousel
  void _generateUniqueRandomNumbers() {
    var random = Random();
    randomImageIndex.clear();
    while (randomImageIndex.length < 3) {
      var randomNumber = random.nextInt(17);
      if (!randomImageIndex.contains(randomNumber)) {
        randomImageIndex.add(randomNumber);
      }
    }
  }

  /// Start automatic carousel animation every 4 seconds
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentIndex.value < randomImageIndex.length - 1) {
        currentIndex.value++;
      } else {
        currentIndex.value = 0;
      }
      _animateScroll();
    });
  }

  /// Animate scroll to show next carousel item
  void _animateScroll() {
    // Only animate if the scroll controller is attached to a scroll view
    if (scrollController.hasClients) {
      scrollController.animateTo(
        currentIndex.value * 300.0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutCirc,
      );
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    scrollController.dispose();
    super.onClose();
  }
}