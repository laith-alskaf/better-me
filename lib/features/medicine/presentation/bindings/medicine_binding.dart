import 'package:BetterMe/features/medicine/presentation/controllers/medicine_controller.dart';
import 'package:get/get.dart';

/// Binding لصفحة الأدوية الأساسية
/// مسؤول عن تهيئة MedicineController بشكل صحيح
class MedicineBinding extends Bindings {
  @override
  void dependencies() {
    // تسجيل MedicineController كـ Lazy Singleton مع fenix: true
    // fenix: true = يبقى حياً حتى إذا تم حذفه من الذاكرة
    // هذا يضمن عدم حدوث خطأ "[Get] the improper use of a GetX"
    Get.lazyPut<MedicineController>(
      () => MedicineController(),
      fenix: true, // ✅ المفتاح: يحافظ على Controller عند العودة للصفحة
    );
  }
}