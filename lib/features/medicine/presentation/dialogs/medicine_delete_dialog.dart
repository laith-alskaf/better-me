import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/design_system.dart';

class MedicineDeleteDialog extends StatelessWidget {
  final String medicineName;
  final VoidCallback onConfirm;

  const MedicineDeleteDialog({
    super.key,
    required this.medicineName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('delete_medicine'.tr),
      content: RichText(
        text: TextSpan(
          text: 'confirm_delete_medicine_text'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: ' "$medicineName" ',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: 'question'.tr,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text('cancel'.tr),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'delete'.tr,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}