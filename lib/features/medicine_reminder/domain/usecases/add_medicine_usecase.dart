import 'package:dartz/dartz.dart';
import 'package:BetterMe/core/error/failures.dart';
import '../../data/models/medicine_model.dart';
import '../repositories/medicine_repository.dart';

/// Use Case لإضافة دواء جديد
/// يمكن إضافة Validation أو Business Logic هنا
class AddMedicineUseCase {
  final MedicineRepository repository;

  const AddMedicineUseCase(this.repository);

  /// تنفيذ Use Case
  /// Parameters:
  /// - medicine: الدواء المراد إضافته
  /// Returns: Either<Failure, void>
  Future<Either<Failure, void>> call(MedicineModel medicine) async {
    // يمكن إضافة Validation هنا
    final validationResult = _validateMedicine(medicine);
    if (validationResult != null) {
      return Left(validationResult);
    }

    // تنفيذ العملية
    return await repository.addMedicine(medicine);
  }

  /// التحقق من صحة بيانات الدواء
  /// Returns: ValidationFailure إذا كانت البيانات غير صحيحة
  ValidationFailure? _validateMedicine(MedicineModel medicine) {
    final errors = <String, String>{};

    // التحقق من اسم الدواء
    if (medicine.medicineName.trim().isEmpty) {
      errors['medicineName'] = 'اسم الدواء مطلوب';
    }

    // التحقق من الجرعة
    if (medicine.dosage <= 0) {
      errors['dosage'] = 'الجرعة يجب أن تكون أكبر من صفر';
    }

    // إرجاع الأخطاء إن وجدت
    if (errors.isNotEmpty) {
      return ValidationFailure(
        'بيانات الدواء غير صحيحة',
        fieldErrors: errors,
      );
    }

    return null;
  }
}