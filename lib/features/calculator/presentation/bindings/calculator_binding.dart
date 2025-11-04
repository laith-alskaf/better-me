import 'package:get/get.dart';
import '../controllers/calculator_controller.dart';

/// CalculatorBinding
/// GetX dependency injection binding for Calculator feature
class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ إضافة fenix: true لمنع خطأ GetX عند العودة للصفحة
    Get.lazyPut<CalculatorController>(
      () => CalculatorController(),
      fenix: true,
    );
  }
}