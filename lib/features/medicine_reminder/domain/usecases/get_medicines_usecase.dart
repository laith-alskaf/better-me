import 'package:dartz/dartz.dart';
import 'package:BetterMe/core/error/failures.dart';
import '../../data/models/medicine_model.dart';
import '../repositories/medicine_repository.dart';

/// Use Case لجلب قائمة الأدوية
/// يطبق مبدأ Single Responsibility
/// يفصل Business Logic عن Presentation Layer
class GetMedicinesUseCase {
  final MedicineRepository repository;

  const GetMedicinesUseCase(this.repository);

  /// تنفيذ Use Case
  /// Returns: Either<Failure, List<MedicineModel>>
  Future<Either<Failure, List<MedicineModel>>> call() async {
    return await repository.getMedicines();
  }

  /// تنفيذ مع معالجة إضافية (مثال)
  /// يمكن إضافة Business Logic هنا
  Future<Either<Failure, List<MedicineModel>>> execute({
    bool sortByName = false,
    bool filterActive = false,
  }) async {
    final result = await repository.getMedicines();

    return result.fold(
      (failure) => Left(failure),
      (medicines) {
        var filteredMedicines = medicines;

        // تطبيق Business Logic
        if (filterActive) {
          // filteredMedicines = filteredMedicines.where((m) => m.isActive).toList();
        }

        if (sortByName) {
          filteredMedicines.sort((a, b) => a.medicineName.compareTo(b.medicineName));
        }

        return Right(filteredMedicines);
      },
    );
  }
}