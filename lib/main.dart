import 'package:BetterMe/app/bindings/app_bindings.dart';
import 'package:BetterMe/app/my_app.dart';
import 'package:flutter/material.dart';

/// Entry point of the application
/// نقطة الدخول الرئيسية للتطبيق
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app bindings (services, controllers, etc.)
  await AppBindings.init();

  runApp(const MyApp());
}