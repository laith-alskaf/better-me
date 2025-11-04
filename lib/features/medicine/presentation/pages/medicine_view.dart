import 'package:BetterMe/features/medicine/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';

class MedicineView extends GetView<MedicineController> {
  const MedicineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.medicineList$.isEmpty
            ? EmptyMedicineState(
                onAddPressed: () => _showAddDialog(),
              )
            : MedicineListView(
                medicines: controller.medicineList$,
                onEdit: (index) => _showEditDialog(index),
                onDelete: _showDeleteDialog,
              ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _showAddDialog,
      backgroundColor: AppColors.primary,
      icon: const Icon(Icons.add_rounded),
      label: Text('add_medicine'.tr),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
      ),
    );
  }

  void _showAddDialog() {
    Get.to(() => const NewEntryView());
  }

  void _showEditDialog(int index) {
    final medicine = controller.medicineList$[index];
    Get.to(
      () => NewEntryView(
        medicineToEdit: medicine,
        isEditing: true,
      ),
    );
  }

  void _showDeleteDialog(index) {
    final medicine = controller.medicineList$[index];
    MedicineDialogs.showDeleteDialog(
      medicineName: medicine.medicineName ?? 'Unknown',
      onConfirm: () {
        controller.removeMedicineAt(index);
        Get.back();
      },
    );
  }
}