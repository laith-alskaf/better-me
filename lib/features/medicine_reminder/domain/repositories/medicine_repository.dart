import 'package:dartz/dartz.dart';
import 'package:BetterMe/core/error/failures.dart';
import '../../data/models/medicine_model.dart';

/// Repository Interface (Domain Layer)
/// يحدد العقد (Contract) لعمليات الأدوية
/// التطبيق الفعلي في Data Layer
abstract class MedicineRepository {
  /// الحصول على قائمة الأدوية
  /// Returns: Either<Failure, List<MedicineModel>>
  /// - Left: Failure إذا فشلت العملية
  /// - Right: قائمة الأدوية إذا نجحت
  Future<Either<Failure, List<MedicineModel>>> getMedicines();

  /// إضافة دواء جديد
  /// Returns: Either<Failure, void>
  /// - Left: Failure إذا فشلت العملية
  /// - Right: void إذا نجحت
  Future<Either<Failure, void>> addMedicine(MedicineModel medicine);

  /// تحديث دواء
  /// Returns: Either<Failure, void>
  Future<Either<Failure, void>> updateMedicine(MedicineModel medicine);

  /// حذف دواء
  /// Returns: Either<Failure, void>
  Future<Either<Failure, void>> deleteMedicine(String medicineId);

  /// حفظ قائمة كاملة
  /// Returns: Either<Failure, void>
  Future<Either<Failure, void>> saveMedicines(List<MedicineModel> medicines);

  /// مسح جميع الأدوية
  /// Returns: Either<Failure, void>
  Future<Either<Failure, void>> clearAll();
}