import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'medicine_delete_dialog.dart';

class MedicineDialogs {
  

  static void showDeleteDialog({
    required String medicineName,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      MedicineDeleteDialog(
        medicineName: medicineName,
        onConfirm: onConfirm,
      ),
    );
  }
}