import 'package:dartz/dartz.dart';
import 'package:BetterMe/core/error/failures.dart';
import '../../data/models/medicine_model.dart';
import '../repositories/medicine_repository.dart';

/// Use Case لتحديث دواء موجود
class UpdateMedicineUseCase {
  final MedicineRepository repository;

  const UpdateMedicineUseCase(this.repository);

  /// تنفيذ Use Case
  /// Parameters:
  /// - medicine: الدواء المحدث
  /// Returns: Either<Failure, void>
  Future<Either<Failure, void>> call(MedicineModel medicine) async {
    // يمكن إضافة Validation
    final validationResult = _validateMedicine(medicine);
    if (validationResult != null) {
      return Left(validationResult);
    }

    return await repository.updateMedicine(medicine);
  }

  /// التحقق من صحة بيانات الدواء
  ValidationFailure? _validateMedicine(MedicineModel medicine) {
    final errors = <String, String>{};

    // التحقق من ID
    if (medicine.id?.isEmpty ?? true) {
      errors['id'] = 'معرف الدواء مطلوب';
    }

    // التحقق من اسم الدواء
    if (medicine.medicineName.trim().isEmpty) {
      errors['medicineName'] = 'اسم الدواء مطلوب';
    }

    // التحقق من الجرعة
    if (medicine.dosage <= 0) {
      errors['dosage'] = 'الجرعة يجب أن تكون أكبر من صفر';
    }

    if (errors.isNotEmpty) {
      return ValidationFailure(
        'بيانات الدواء غير صحيحة',
        fieldErrors: errors,
      );
    }

    return null;
  }
}