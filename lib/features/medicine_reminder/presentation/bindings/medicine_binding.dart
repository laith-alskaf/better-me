import 'package:get/get.dart';
import 'package:BetterMe/core/services/storage_service.dart';
import '../../data/datasources/medicine_local_datasource.dart';
import '../../data/repositories/medicine_repository_impl.dart';
import '../../domain/repositories/medicine_repository.dart';
import '../../domain/usecases/get_medicines_usecase.dart';
import '../../domain/usecases/add_medicine_usecase.dart';
import '../../domain/usecases/update_medicine_usecase.dart';
import '../../domain/usecases/delete_medicine_usecase.dart';
import '../controllers/medicine_controller.dart';

/// Binding لإدارة الأدوية
/// مسؤول عن تهيئة Dependency Injection Tree:
/// Controller -> Use Cases -> Repository -> Data Source -> Storage Service
class MedicineBinding extends Bindings {
  @override
  void dependencies() {
    // ===================== Data Layer =====================
    
    /// Data Source - التواصل المباشر مع Storage
    Get.lazyPut<MedicineLocalDataSource>(
      () => MedicineLocalDataSourceImpl(
        Get.find<StorageService>(), // يجب أن يكون مُسجل في AppBindings
      ),
      fenix: true,
    );

    /// Repository Implementation - تحويل Exceptions إلى Failures
    Get.lazyPut<MedicineRepository>(
      () => MedicineRepositoryImpl(
        Get.find<MedicineLocalDataSource>(),
      ),
      fenix: true,
    );

    // ===================== Domain Layer - Use Cases =====================

    /// Use Case: جلب قائمة الأدوية
    Get.lazyPut<GetMedicinesUseCase>(
      () => GetMedicinesUseCase(
        Get.find<MedicineRepository>(),
      ),
      fenix: true,
    );

    /// Use Case: إضافة دواء جديد
    Get.lazyPut<AddMedicineUseCase>(
      () => AddMedicineUseCase(
        Get.find<MedicineRepository>(),
      ),
      fenix: true,
    );

    /// Use Case: تحديث دواء
    Get.lazyPut<UpdateMedicineUseCase>(
      () => UpdateMedicineUseCase(
        Get.find<MedicineRepository>(),
      ),
      fenix: true,
    );

    /// Use Case: حذف دواء
    Get.lazyPut<DeleteMedicineUseCase>(
      () => DeleteMedicineUseCase(
        Get.find<MedicineRepository>(),
      ),
      fenix: true,
    );

    // ===================== Presentation Layer =====================

    /// Controller - يستخدم Use Cases
    Get.lazyPut<MedicineController>(
      () => MedicineController(
        getMedicinesUseCase: Get.find<GetMedicinesUseCase>(),
        addMedicineUseCase: Get.find<AddMedicineUseCase>(),
        updateMedicineUseCase: Get.find<UpdateMedicineUseCase>(),
        deleteMedicineUseCase: Get.find<DeleteMedicineUseCase>(),
      ),
      fenix: true, // يبقى حياً حتى إذا تم حذفه
    );
  }
}