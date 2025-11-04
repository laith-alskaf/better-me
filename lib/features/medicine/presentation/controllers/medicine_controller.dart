import 'dart:convert';
import 'package:BetterMe/features/medicine/data/models/medicine.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// MedicineController - إدارة قائمة الأدوية مع Reactive GetX
/// ✅ استخدام RxList للـ reactive updates
class MedicineController extends GetxController {
  late final FlutterLocalNotificationsPlugin _notificationsPlugin;
  
  final medicineList$ = <Medicine>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
    loadMedicines();
  }

  Future<void> _initializeNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _notificationsPlugin.initialize(initSettings);
  }

  /// تحميل الأدوية من التخزين المحلي
  Future<void> loadMedicines() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList('medicines') ?? [];
      
      final medicines = jsonList
          .map((json) => Medicine.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      
      medicineList$.assignAll(medicines);
    } catch (e) {
      AppSnackBar.show(
        Get.context!,
        message: 'error_loading_medicines'.tr,
        type: SnackBarType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// إضافة دواء جديد
  Future<void> addMedicine(Medicine medicine) async {
    try {
      medicineList$.add(medicine);
      await _saveMedicinesToStorage();
      
      AppSnackBar.show(
        Get.context!,
        message: 'medicine_added_successfully'.tr,
        type: SnackBarType.success,
      );
    } catch (e) {
      _handleError('error_adding_medicine'.tr);
    }
  }

  /// تحديث دواء موجود بـ index
  Future<void> updateMedicine(int index, Medicine medicine) async {
    try {
      if (index < 0 || index >= medicineList$.length) return;
      
      medicineList$[index] = medicine;
      medicineList$.refresh();
      
      await _saveMedicinesToStorage();
      
      AppSnackBar.show(
        Get.context!,
        message: 'medicine_updated_successfully'.tr,
        type: SnackBarType.success,
      );
    } catch (e) {
      _handleError('error_updating_medicine'.tr);
    }
  }

  /// تحديث دواء موجود بـ Medicine object
  Future<void> updateMedicineByObject(Medicine oldMedicine, Medicine newMedicine) async {
    try {
      final index = medicineList$.indexWhere(
        (m) => m.medicineName == oldMedicine.medicineName && 
               m.startTime == oldMedicine.startTime
      );
      
      if (index == -1) return;
      
      medicineList$[index] = newMedicine;
      medicineList$.refresh();
      
      await _saveMedicinesToStorage();
      
      AppSnackBar.show(
        Get.context!,
        message: 'medicine_updated_successfully'.tr,
        type: SnackBarType.success,
      );
    } catch (e) {
      _handleError('error_updating_medicine'.tr);
    }
  }

  /// حذف دواء بالـ index
  Future<void> removeMedicineAt(int index) async {
    try {
      if (index < 0 || index >= medicineList$.length) return;
      
      final medicine = medicineList$[index];
      
      // إلغاء التنبيهات المجدولة
      await _cancelNotifications(medicine);
      
      medicineList$.removeAt(index);
      
      await _saveMedicinesToStorage();
      
      AppSnackBar.show(
        Get.context!,
        message: 'medicine_deleted_successfully'.tr,
        type: SnackBarType.success,
      );
    } catch (e) {
      _handleError('error_deleting_medicine'.tr);
    }
  }

  /// حذف دواء بالـ Medicine object
  Future<void> removeMedicine(Medicine medicine) async {
    try {
      final index = medicineList$.indexWhere(
        (m) => m.medicineName == medicine.medicineName && 
               m.startTime == medicine.startTime
      );
      
      if (index == -1) return;
      
      await removeMedicineAt(index);
    } catch (e) {
      _handleError('error_deleting_medicine'.tr);
    }
  }

  /// حفظ الأدوية في التخزين المحلي
  Future<void> _saveMedicinesToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = medicineList$
          .map((medicine) => jsonEncode(medicine.toJson()))
          .toList();
      
      await prefs.setStringList('medicines', jsonList);
    } catch (e) {
      _handleError('error_saving_medicines'.tr);
    }
  }

  /// إلغاء التنبيهات المجدولة للدواء
  Future<void> _cancelNotifications(Medicine medicine) async {
    try {
      if (medicine.notificationIDs == null) return;
      
      for (final id in medicine.notificationIDs!) {
        try {
          await _notificationsPlugin.cancel(int.parse(id.toString()));
        } catch (e) {
          // تجاهل الأخطاء في إلغاء التنبيهات الفردية
        }
      }
    } catch (e) {
      // تجاهل الأخطاء الشاملة
    }
  }

  /// معالجة الأخطاء
  void _handleError(String message) {
    AppSnackBar.show(
      Get.context!,
      message: message,
      type: SnackBarType.error,
    );
  }
}