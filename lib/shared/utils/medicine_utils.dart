import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BetterMe/config/theme/app_colors.dart';

/// MedicineUtils - أدوات مساعدة لإدارة الأدوية
class MedicineUtils {
  MedicineUtils._(); // Private constructor

  /// الحصول على أيقونة نوع الدواء
  static IconData getMedicineTypeIcon(String medicineType) {
    switch (medicineType.toLowerCase()) {
      case 'pill':
      case 'حبة':
        return Icons.circle_outlined;
      case 'tablet':
      case 'قرص':
        return Icons.rectangle_outlined;
      case 'capsule':
      case 'كبسولة':
        return Icons.grain;
      case 'liquid':
      case 'سائل':
        return Icons.local_drink_outlined;
      case 'injection':
      case 'حقنة':
        return Icons.medical_services_outlined;
      case 'syrup':
      case 'شراب':
        return Icons.water_drop_outlined;
      case 'cream':
      case 'كريم':
        return Icons.palette_outlined;
      default:
        return Icons.medication_outlined;
    }
  }

  /// الحصول على لون نوع الدواء
  static Color getMedicineTypeColor(String medicineType) {
    final hash = medicineType.hashCode;
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.warning,
      AppColors.error,
      AppColors.success,
      AppColors.info,
    ];
    return colors[hash % colors.length];
  }

  /// تنسيق نص التكرار
  static String formatFrequency(int interval) {
    if (interval == 1) {
      return 'every_hour'.tr;
    } else {
      return 'every_hours'.tr.replaceFirst('{{count}}', interval.toString());
    }
  }

  /// الحصول على نص الحالة مع الترجمة
  static String getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'taken':
        return 'taken'.tr;
      case 'missed':
        return 'missed'.tr;
      case 'pending':
      default:
        return 'pending'.tr;
    }
  }

  /// الحصول على لون الحالة
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'taken':
        return AppColors.success;
      case 'missed':
        return AppColors.error;
      case 'pending':
      default:
        return AppColors.warning;
    }
  }

  /// الحصول على أيقونة الحالة
  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'taken':
        return Icons.check_circle;
      case 'missed':
        return Icons.cancel;
      case 'pending':
      default:
        return Icons.schedule;
    }
  }

  /// تنسيق الوقت التالي للجرعة
  static String formatNextDoseTime(DateTime? nextTime) {
    if (nextTime == null) return 'no_end_date'.tr;

    final now = DateTime.now();
    final difference = nextTime.difference(now);

    if (difference.inHours == 0 && difference.inMinutes > 0) {
      return '${'next_dose'.tr}: ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return '${'next_dose'.tr}: ${difference.inHours} ساعات';
    } else {
      return '${'next_dose'.tr}: ${nextTime.day}/${nextTime.month}/${nextTime.year}';
    }
  }

  /// التحقق من ما إذا كان يجب إظهار تنبيه الدواء
  static bool shouldShowReminder(DateTime reminderTime) {
    final now = DateTime.now();
    final difference = reminderTime.difference(now);
    // إظهار التنبيه إذا كان في الـ 30 دقيقة القادمة
    return difference.inMinutes >= 0 && difference.inMinutes <= 30;
  }

  /// الحصول على قائمة أنواع الأدوية المترجمة
  static List<String> getMedicineTypes() {
    return [
      'pill'.tr,
      'tablet'.tr,
      'capsule'.tr,
      'liquid'.tr,
      'injection'.tr,
      'syrup'.tr,
      'cream'.tr,
    ];
  }

  /// الحصول على قائمة التكرار
  static List<Map<String, dynamic>> getFrequencyOptions() {
    return [
      {'value': 1, 'label': 'every_hour'.tr},
      {'value': 2, 'label': '2x'.tr},
      {'value': 3, 'label': '3x'.tr},
      {'value': 4, 'label': '4x'.tr},
      {'value': 6, 'label': '6x'.tr},
      {'value': 8, 'label': '8x'.tr},
      {'value': 12, 'label': '12x'.tr},
      {'value': 24, 'label': 'daily'.tr},
    ];
  }
}