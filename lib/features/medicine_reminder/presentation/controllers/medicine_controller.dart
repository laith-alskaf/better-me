import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:BetterMe/core/error/failures.dart';
import '../../data/models/medicine_model.dart';
import '../../domain/usecases/get_medicines_usecase.dart';
import '../../domain/usecases/add_medicine_usecase.dart';
import '../../domain/usecases/update_medicine_usecase.dart';
import '../../domain/usecases/delete_medicine_usecase.dart';

/// GetX Controller لإدارة الأدوية
/// يستخدم Clean Architecture مع Use Cases
/// مسؤول عن:
/// - عرض قائمة الأدوية
/// - إضافة/حذف/تحديث الأدوية
/// - إدارة الإشعارات المحلية
/// - معالجة الأخطاء وعرضها للمستخدم
class MedicineController extends GetxController {
  // ===================== Use Cases (Dependencies) =====================
  final GetMedicinesUseCase getMedicinesUseCase;
  final AddMedicineUseCase addMedicineUseCase;
  final UpdateMedicineUseCase updateMedicineUseCase;
  final DeleteMedicineUseCase deleteMedicineUseCase;

  MedicineController({
    required this.getMedicinesUseCase,
    required this.addMedicineUseCase,
    required this.updateMedicineUseCase,
    required this.deleteMedicineUseCase,
  });

  // ===================== Services =====================
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // ===================== Reactive Variables =====================
  /// قائمة الأدوية الحالية
  final Rx<List<MedicineModel>> medicineList = Rx<List<MedicineModel>>([]);

  /// حالة التحميل
  final RxBool isLoading = false.obs;

  /// رسالة الخطأ
  final Rx<String?> errorMessage = Rx<String?>(null);

  /// عدد الأدوية
  RxInt get medicineCount => medicineList.value.length.obs;

  // ===================== Lifecycle =====================
  @override
  void onInit() {
    super.onInit();
    loadMedicines();
  }

  // ===================== Public Methods =====================

  /// تحميل قائمة الأدوية
  Future<void> loadMedicines() async {
    try {
      isLoading(true);
      errorMessage(null);

      // استدعاء Use Case
      final result = await getMedicinesUseCase.call();

      // معالجة النتيجة
      result.fold(
        (failure) {
          // في حالة الفشل
          errorMessage(_mapFailureToMessage(failure));
          medicineList([]);
        },
        (medicines) {
          // في حالة النجاح
          medicineList(medicines);
          errorMessage(null);
        },
      );
    } catch (e) {
      errorMessage('حدث خطأ غير متوقع: ${e.toString()}');
      printError(info: 'Unexpected error in loadMedicines: $e');
    } finally {
      isLoading(false);
    }
  }

  /// إضافة دواء جديد
  Future<void> addMedicine(MedicineModel newMedicine) async {
    try {
      isLoading(true);
      errorMessage(null);

      // استدعاء Use Case
      final result = await addMedicineUseCase.call(newMedicine);

      // معالجة النتيجة
      result.fold(
        (failure) {
          // في حالة الفشل
          final message = _mapFailureToMessage(failure);
          errorMessage(message);
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        },
        (_) {
          // في حالة النجاح
          Get.snackbar(
            'نجاح',
            'تمت إضافة الدواء بنجاح',
            snackPosition: SnackPosition.BOTTOM,
          );
          // إعادة تحميل القائمة
          loadMedicines();
        },
      );
    } catch (e) {
      errorMessage('حدث خطأ غير متوقع');
      printError(info: 'Unexpected error in addMedicine: $e');
    } finally {
      isLoading(false);
    }
  }

  /// تحديث دواء موجود
  Future<void> updateMedicine(MedicineModel updatedMedicine) async {
    try {
      isLoading(true);
      errorMessage(null);

      // استدعاء Use Case
      final result = await updateMedicineUseCase.call(updatedMedicine);

      // معالجة النتيجة
      result.fold(
        (failure) {
          // في حالة الفشل
          final message = _mapFailureToMessage(failure);
          errorMessage(message);
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        },
        (_) {
          // في حالة النجاح
          Get.snackbar(
            'تم التحديث',
            'تم تحديث الدواء بنجاح',
            snackPosition: SnackPosition.BOTTOM,
          );
          // إعادة تحميل القائمة
          loadMedicines();
        },
      );
    } catch (e) {
      errorMessage('حدث خطأ غير متوقع');
      printError(info: 'Unexpected error in updateMedicine: $e');
    } finally {
      isLoading(false);
    }
  }

  /// حذف دواء
  Future<void> removeMedicine(MedicineModel medicineToRemove) async {
    try {
      isLoading(true);
      errorMessage(null);

      // حذف الإشعارات المرتبطة
      await _cancelNotifications(medicineToRemove);

      // استدعاء Use Case
      final result = await deleteMedicineUseCase.call(medicineToRemove.id ?? '');

      // معالجة النتيجة
      result.fold(
        (failure) {
          // في حالة الفشل
          final message = _mapFailureToMessage(failure);
          errorMessage(message);
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        },
        (_) {
          // في حالة النجاح
          Get.snackbar(
            'تم الحذف',
            'تم حذف الدواء بنجاح',
            snackPosition: SnackPosition.BOTTOM,
          );
          // إعادة تحميل القائمة
          loadMedicines();
        },
      );
    } catch (e) {
      errorMessage('حدث خطأ غير متوقع');
      printError(info: 'Unexpected error in removeMedicine: $e');
    } finally {
      isLoading(false);
    }
  }

  /// الحصول على دواء محدد بناءً على المعرف
  MedicineModel? getMedicineById(String? id) {
    try {
      return medicineList.value.firstWhereOrNull((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  /// البحث عن أدوية بناءً على الاسم
  List<MedicineModel> searchMedicines(String query) {
    if (query.isEmpty) {
      return medicineList.value;
    }
    return medicineList.value
        .where((m) => m.medicineName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// حذف جميع الأدوية
  Future<void> clearAllMedicines() async {
    try {
      isLoading(true);

      // حذف جميع الإشعارات
      for (final medicine in medicineList.value) {
        await _cancelNotifications(medicine);
      }

      // حذف جميع الأدوية واحداً تلو الآخر
      for (final medicine in medicineList.value) {
        await deleteMedicineUseCase.call(medicine.id ?? '');
      }

      // إعادة تحميل القائمة
      await loadMedicines();

      Get.snackbar(
        'تم الحذف',
        'تم حذف جميع الأدوية',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      errorMessage('فشل حذف الأدوية');
      printError(info: 'Error in clearAllMedicines: $e');
    } finally {
      isLoading(false);
    }
  }

  // ===================== Private Methods =====================

  /// تحويل Failure إلى رسالة للمستخدم
  String _mapFailureToMessage(Failure failure) {
    if (failure is CacheFailure) {
      return 'خطأ في التخزين المحلي';
    } else if (failure is DataParsingFailure) {
      return 'خطأ في قراءة البيانات';
    } else if (failure is ValidationFailure) {
      return failure.message;
    } else if (failure is NotFoundFailure) {
      return 'العنصر غير موجود';
    } else if (failure is NetworkFailure) {
      return 'خطأ في الاتصال بالإنترنت';
    } else if (failure is UnexpectedFailure) {
      return 'حدث خطأ غير متوقع';
    } else {
      return failure.message;
    }
  }

  /// إلغاء الإشعارات المرتبطة بدواء معين
  Future<void> _cancelNotifications(MedicineModel medicine) async {
    try {
      if (medicine.notificationIds != null && medicine.notificationIds!.isNotEmpty) {
        for (final id in medicine.notificationIds!) {
          await _notificationsPlugin.cancel(id);
        }
      }
    } catch (e) {
      printError(info: 'Error canceling notifications: $e');
    }
  }
}