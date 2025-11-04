import 'package:dartz/dartz.dart';
import 'package:BetterMe/core/error/failures.dart';
import 'package:BetterMe/core/error/exceptions.dart';
import 'package:BetterMe/core/services/logger_service.dart';
import '../../domain/repositories/medicine_repository.dart';
import '../datasources/medicine_local_datasource.dart';
import '../models/medicine_model.dart';

/// التطبيق الفعلي للـ Repository (Data Layer)
/// يحول Exceptions إلى Failures
/// يطبق Error Handling موحد
class MedicineRepositoryImpl implements MedicineRepository {
  final MedicineLocalDataSource localDataSource;

  const MedicineRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<MedicineModel>>> getMedicines() async {
    try {
      final medicines = await localDataSource.getMedicines();
      LoggerService.info('✓ Retrieved ${medicines.length} medicines from datasource');
      return Right(medicines);
    } on CacheException catch (e) {
      LoggerService.error('✗ Cache error retrieving medicines', e);
      return Left(CacheFailure('فشل تحميل الأدوية من التخزين المحلي', e));
    } on ParsingException catch (e) {
      LoggerService.error('✗ Parsing error retrieving medicines', e);
      return Left(DataParsingFailure('خطأ في قراءة بيانات الأدوية', e));
    } catch (e) {
      LoggerService.error('✗ Unexpected error retrieving medicines', e);
      return Left(UnexpectedFailure('حدث خطأ غير متوقع', e));
    }
  }

  @override
  Future<Either<Failure, void>> addMedicine(MedicineModel medicine) async {
    try {
      await localDataSource.saveMedicine(medicine);
      LoggerService.success('✓ Medicine added: ${medicine.medicineName}');
      return const Right(null);
    } on CacheException catch (e) {
      LoggerService.error('✗ Cache error adding medicine', e);
      return Left(CacheFailure('فشل إضافة الدواء إلى التخزين المحلي', e));
    } on ValidationException catch (e) {
      LoggerService.error('✗ Validation error adding medicine', e);
      return Left(ValidationFailure(
        'بيانات الدواء غير صحيحة',
        fieldErrors: e.fieldErrors,
        error: e,
      ));
    } catch (e) {
      LoggerService.error('✗ Unexpected error adding medicine', e);
      return Left(UnexpectedFailure('فشل إضافة الدواء', e));
    }
  }

  @override
  Future<Either<Failure, void>> updateMedicine(MedicineModel medicine) async {
    try {
      await localDataSource.updateMedicine(medicine);
      LoggerService.success('✓ Medicine updated: ${medicine.medicineName}');
      return const Right(null);
    } on NotFoundException catch (e) {
      LoggerService.error('✗ Medicine not found for update', e);
      return Left(NotFoundFailure('الدواء غير موجود', e));
    } on CacheException catch (e) {
      LoggerService.error('✗ Cache error updating medicine', e);
      return Left(CacheFailure('فشل تحديث الدواء', e));
    } on ValidationException catch (e) {
      LoggerService.error('✗ Validation error updating medicine', e);
      return Left(ValidationFailure(
        'بيانات الدواء غير صحيحة',
        fieldErrors: e.fieldErrors,
        error: e,
      ));
    } catch (e) {
      LoggerService.error('✗ Unexpected error updating medicine', e);
      return Left(UnexpectedFailure('فشل تحديث الدواء', e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedicine(String medicineId) async {
    try {
      await localDataSource.deleteMedicine(medicineId);
      LoggerService.success('✓ Medicine deleted: $medicineId');
      return const Right(null);
    } on NotFoundException catch (e) {
      LoggerService.error('✗ Medicine not found for deletion', e);
      return Left(NotFoundFailure('الدواء غير موجود', e));
    } on CacheException catch (e) {
      LoggerService.error('✗ Cache error deleting medicine', e);
      return Left(CacheFailure('فشل حذف الدواء', e));
    } catch (e) {
      LoggerService.error('✗ Unexpected error deleting medicine', e);
      return Left(UnexpectedFailure('فشل حذف الدواء', e));
    }
  }

  @override
  Future<Either<Failure, void>> saveMedicines(List<MedicineModel> medicines) async {
    try {
      await localDataSource.saveMedicines(medicines);
      LoggerService.success('✓ Batch saved: ${medicines.length} medicines');
      return const Right(null);
    } on CacheException catch (e) {
      LoggerService.error('✗ Cache error saving batch', e);
      return Left(CacheFailure('فشل حفظ الأدوية', e));
    } catch (e) {
      LoggerService.error('✗ Unexpected error saving batch', e);
      return Left(UnexpectedFailure('فشل حفظ الأدوية', e));
    }
  }

  @override
  Future<Either<Failure, void>> clearAll() async {
    try {
      await localDataSource.clearAll();
      LoggerService.warning('⚠ All medicines cleared from datasource');
      return const Right(null);
    } on CacheException catch (e) {
      LoggerService.error('✗ Cache error clearing medicines', e);
      return Left(CacheFailure('فشل مسح الأدوية', e));
    } catch (e) {
      LoggerService.error('✗ Unexpected error clearing medicines', e);
      return Left(UnexpectedFailure('فشل مسح الأدوية', e));
    }
  }
}