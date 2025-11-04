import 'package:get/get.dart';
import '../controllers/home_controller.dart';

/// HomeBinding
/// GetX dependency injection binding for Home feature
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ إضافة fenix: true لمنع خطأ GetX عند العودة للصفحة
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
  }
}