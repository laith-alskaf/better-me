import 'package:dartz/dartz.dart';
import 'package:BetterMe/core/error/failures.dart';
import '../repositories/medicine_repository.dart';

/// Use Case لحذف دواء
class DeleteMedicineUseCase {
  final MedicineRepository repository;

  const DeleteMedicineUseCase(this.repository);

  /// تنفيذ Use Case
  /// Parameters:
  /// - medicineId: معرف الدواء المراد حذفه
  /// Returns: Either<Failure, void>
  Future<Either<Failure, void>> call(String medicineId) async {
    // التحقق من صحة ID
    if (medicineId.trim().isEmpty) {
      return const Left(
        ValidationFailure('معرف الدواء مطلوب'),
      );
    }

    return await repository.deleteMedicine(medicineId);
  }
}