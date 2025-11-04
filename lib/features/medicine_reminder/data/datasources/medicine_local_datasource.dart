import 'dart:convert';
import 'package:BetterMe/core/services/storage_service.dart';
import 'package:BetterMe/core/services/logger_service.dart';
import 'package:BetterMe/core/error/exceptions.dart';
import '../models/medicine_model.dart';

/// المصدر المحلي للبيانات (Local Data Source)
/// مسؤول عن تخزين واسترجاع الأدوية من SharedPreferences
abstract class MedicineLocalDataSource {
  /// تحميل قائمة الأدوية
  Future<List<MedicineModel>> getMedicines();

  /// حفظ دواء جديد
  Future<void> saveMedicine(MedicineModel medicine);

  /// تحديث دواء
  Future<void> updateMedicine(MedicineModel medicine);

  /// حذف دواء
  Future<void> deleteMedicine(String medicineId);

  /// حفظ قائمة كاملة
  Future<void> saveMedicines(List<MedicineModel> medicines);

  /// حذف جميع الأدوية
  Future<void> clearAll();
}

/// التطبيق الفعلي للـ Local Data Source
class MedicineLocalDataSourceImpl implements MedicineLocalDataSource {
  final StorageService _storageService;
  static const String _medicinesKey = 'medicines';

  const MedicineLocalDataSourceImpl(this._storageService);

  @override
  Future<List<MedicineModel>> getMedicines() async {
    try {
      final jsonList = _storageService.getStringList(_medicinesKey);

      if (jsonList == null || jsonList.isEmpty) {
        return [];
      }

      final medicines = <MedicineModel>[];
      for (final jsonString in jsonList) {
        try {
          final map = jsonDecode(jsonString) as Map<String, dynamic>;
          medicines.add(MedicineModel.fromJson(map));
        } catch (e) {
          LoggerService.warning('Error parsing medicine: $e', e);
          // رمي استثناء في حالة فشل التحليل
          throw ParsingException('فشل تحليل بيانات الدواء', e);
        }
      }

      return medicines;
    } catch (e) {
      LoggerService.error('Error in getMedicines: $e', e);
      if (e is ParsingException) rethrow;
      throw CacheException('فشل تحميل الأدوية من التخزين', e);
    }
  }

  @override
  Future<void> saveMedicine(MedicineModel medicine) async {
    try {
      final medicines = await getMedicines();
      medicines.add(medicine);
      await saveMedicines(medicines);
      LoggerService.success('Medicine saved: ${medicine.medicineName}');
    } catch (e) {
      LoggerService.error('Error in saveMedicine: $e', e);
      if (e is AppException) rethrow;
      throw CacheException('فشل حفظ الدواء', e);
    }
  }

  @override
  Future<void> updateMedicine(MedicineModel medicine) async {
    try {
      final medicines = await getMedicines();
      final index = medicines.indexWhere((m) => m.id == medicine.id);

      if (index == -1) {
        throw NotFoundException('الدواء غير موجود: ${medicine.id}');
      }

      medicines[index] = medicine;
      await saveMedicines(medicines);
      LoggerService.success('Medicine updated: ${medicine.medicineName}');
    } catch (e) {
      LoggerService.error('Error in updateMedicine: $e', e);
      if (e is AppException) rethrow;
      throw CacheException('فشل تحديث الدواء', e);
    }
  }

  @override
  Future<void> deleteMedicine(String medicineId) async {
    try {
      final medicines = await getMedicines();
      final initialLength = medicines.length;
      medicines.removeWhere((m) => m.id == medicineId);
      
      if (medicines.length == initialLength) {
        throw NotFoundException('الدواء غير موجود: $medicineId');
      }
      
      await saveMedicines(medicines);
      LoggerService.success('Medicine deleted');
    } catch (e) {
      LoggerService.error('Error in deleteMedicine: $e', e);
      if (e is AppException) rethrow;
      throw CacheException('فشل حذف الدواء', e);
    }
  }

  @override
  Future<void> saveMedicines(List<MedicineModel> medicines) async {
    try {
      final jsonList = medicines
          .map((medicine) => jsonEncode(medicine.toJson()))
          .toList();
      _storageService.setStringList(_medicinesKey, jsonList);
      LoggerService.debug('${medicines.length} medicines saved');
    } catch (e) {
      LoggerService.error('Error in saveMedicines: $e', e);
      throw CacheException('فشل حفظ قائمة الأدوية', e);
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      _storageService.remove(_medicinesKey);
      LoggerService.success('All medicines cleared');
    } catch (e) {
      LoggerService.error('Error in clearAll: $e', e);
      throw CacheException('فشل مسح الأدوية', e);
    }
  }
}