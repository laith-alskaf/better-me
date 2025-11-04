import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/features/medicine/data/models/medicine.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'medicine_card.dart';

class MedicineListView extends StatelessWidget {
  final List<Medicine> medicines;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const MedicineListView({
    super.key,
    required this.medicines,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: DesignSystem.paddingBase,
      itemCount: medicines.length,
      separatorBuilder: (_, __) => const SizedBox(height: DesignSystem.base),
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return MedicineCard(
          medicine: medicine,
          onEdit: () => onEdit(index),
          onDelete: () => onDelete(index),
          onTap: () => _showDetailsDialog(medicine),
        );
      },
    );
  }

  void _showDetailsDialog(Medicine medicine) {
    Get.dialog(
      _MedicineDetailsDialog(medicine: medicine),
    );
  }
}

class _MedicineDetailsDialog extends StatelessWidget {
  final Medicine medicine;

  const _MedicineDetailsDialog({
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
      ),
      child: SingleChildScrollView(
        padding: DesignSystem.paddingBase,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: DesignSystem.lg.h),
            _buildDetailRow('medicine_name'.tr, medicine.medicineName ?? 'N/A'),
            _buildDetailRow('medicine_dosage'.tr, '${medicine.dosage ?? 'N/A'} mg'),
            _buildDetailRow('medicine_type'.tr, medicine.medicineType ?? 'N/A'),
            _buildDetailRow('medicine_frequency'.tr, _formatFrequency(medicine.interval ?? 1)),
            SizedBox(height: DesignSystem.lg.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: Get.back,
                child: Text('close'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'medicine_details'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: Get.back,
          child: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: DesignSystem.sm.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: DesignSystem.xs.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatFrequency(int interval) {
    if (interval == 1) return 'every_hour'.tr;
    if (interval == 24) return 'daily'.tr;
    return 'every_$interval hours'.tr;
  }
}