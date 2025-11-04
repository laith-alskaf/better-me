import 'package:BetterMe/config/localization/localization_controller.dart';
import 'package:BetterMe/core/data/repositories/shared_preferences.dart';
import 'package:BetterMe/core/services/connectivity_service.dart';
import 'package:BetterMe/core/services/storage_service.dart';
import 'package:BetterMe/features/calculator/presentation/bindings/calculator_binding.dart';
import 'package:BetterMe/features/home/presentation/bindings/home_binding.dart';
import 'package:BetterMe/features/medicine/presentation/bindings/medicine_binding.dart';
import 'package:BetterMe/features/search_chat/presentation/bindings/search_binding.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App Bindings - Initialize all services and controllers
/// تهيئة جميع الخدمات والتحكمات على مستوى التطبيق
class AppBindings extends Bindings {
  /// Initialize all app-level services
  static Future<void> init() async {
    // ===== LOCALIZATION SERVICE =====
    Get.put<LocalizationController>(
      LocalizationController(),
      permanent: true,
    );

    // ===== SHARED PREFERENCES =====
    final sharedPrefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(
      sharedPrefs,
      permanent: true,
    );

    // ===== STORAGE SERVICE =====
    await Get.putAsync<StorageService>(
      () => StorageService().init(),
      permanent: true,
    );

    // ===== SHARED PREFERENCE WRAPPER =====
    Get.put<SharedPreference>(
      SharedPreference(),
      permanent: true,
    );

    // ===== CONNECTIVITY SERVICE =====
    Get.put<ConnectivityService>(
      ConnectivityService(),
      permanent: true,
    );
  }

  @override
  void dependencies() {
    // ===================== Feature Bindings =====================
    HomeBinding().dependencies();
    MedicineBinding().dependencies();
    CalculatorBinding().dependencies();
    SearchBinding().dependencies();
  }
}
