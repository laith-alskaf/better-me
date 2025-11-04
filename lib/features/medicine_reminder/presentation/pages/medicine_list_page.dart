import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:BetterMe/shared/widgets/buttons/app_button.dart' as app_button;
import 'package:BetterMe/shared/utils/medicine_utils.dart';
import '../controllers/medicine_controller.dart';

/// صفحة قائمة الأدوية - تطبيق احترافي كامل
class MedicineListPage extends StatelessWidget {
  const MedicineListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MedicineController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppScaffoldAppBar(
        titleKey: 'my_medicines',
        backgroundColor: AppColors.primary,
      ),
      body: Obx(
        () {
          // جاري التحميل
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                  SizedBox(height: DesignSystem.base.h),
                  Text(
                    'loading_data'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          // قائمة فارغة
          if (controller.medicineList.value.isEmpty) {
            return EmptyMedicineState(
              onAddPressed: () => _showAddMedicineDialog(context, controller),
              title: 'no_medicines',
              subtitle: 'add_first_medicine',
              actionButtonText: 'add_medicine',
            );
          }

          // عرض القائمة
          return MedicineListContent(
            controller: controller,
            onAddPressed: () => _showAddMedicineDialog(context, controller),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMedicineDialog(context, controller),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: DesignSystem.elevationMedium,
        icon: const Icon(Icons.add_rounded, size: 24),
        label: Text(
          'add_medicine'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusModernLarge),
        ),
      ),
    );
  }

  void _showAddMedicineDialog(BuildContext context, MedicineController controller) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusModernExtraLarge),
        ),
        elevation: DesignSystem.elevationHigh,
        child: _AddMedicineForm(
          controller: controller,
        ),
      ),
    );
  }
}

/// محتوى قائمة الأدوية
class MedicineListContent extends StatelessWidget {
  const MedicineListContent({
    Key? key,
    required this.controller,
    required this.onAddPressed,
  }) : super(key: key);

  final MedicineController controller;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.loadMedicines(),
      backgroundColor: AppColors.primary,
      color: AppColors.background,
      child: ListView.builder(
        padding: DesignSystem.paddingBase,
        itemCount: controller.medicineList.value.length,
        itemBuilder: (context, index) {
          final medicine = controller.medicineList.value[index];

          return MedicineCard(
            medicineName: medicine.medicineName,
            dosage: '${medicine.dosage} mg',
            medicineType: medicine.medicineType,
            frequency: MedicineUtils.formatFrequency(medicine.interval),
            status: 'pending',
            backgroundColor: AppColors.background,
            onTap: () => _showMedicineDetails(context, medicine, controller),
            onEdit: () => _showEditMedicineDialog(context, medicine, controller),
            onDelete: () =>
                _showDeleteConfirmation(context, medicine, controller),
          );
        },
      ),
    );
  }

  void _showMedicineDetails(
    BuildContext context,
    dynamic medicine,
    MedicineController controller,
  ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusModernExtraLarge),
        ),
        elevation: DesignSystem.elevationHigh,
        child: SingleChildScrollView(
          padding: DesignSystem.paddingBase,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'view_details'.tr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: Get.back,
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: DesignSystem.base.h),

              MedicineInfoItem(
                label: 'medicine_name'.tr,
                value: medicine.medicineName,
                icon: Icons.medication_outlined,
              ),
              SizedBox(height: DesignSystem.base.h),

              MedicineInfoItem(
                label: 'medicine_dosage'.tr,
                value: '${medicine.dosage} mg',
                icon: Icons.scale,
              ),
              SizedBox(height: DesignSystem.base.h),

              MedicineInfoItem(
                label: 'type'.tr,
                value: medicine.medicineType,
                icon: MedicineUtils.getMedicineTypeIcon(medicine.medicineType),
                backgroundColor: MedicineUtils.getMedicineTypeColor(medicine.medicineType)
                    .withValues(alpha: 0.1),
              ),
              SizedBox(height: DesignSystem.base.h),

              MedicineInfoItem(
                label: 'medicine_frequency'.tr,
                value: MedicineUtils.formatFrequency(medicine.interval),
                icon: Icons.schedule,
              ),
              SizedBox(height: DesignSystem.lg.h),

              MedicineActionButtons(
                onEdit: () {
                  Get.back();
                  _showEditMedicineDialog(context, medicine, controller);
                },
                onDelete: () {
                  Get.back();
                  _showDeleteConfirmation(context, medicine, controller);
                },
              ),
              SizedBox(height: DesignSystem.base.h),
              AppButton(
                onPressed: Get.back,
                label: 'close'.tr,
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.textPrimary,
                width: double.infinity,
                style: app_button.ButtonStyle.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditMedicineDialog(
    BuildContext context,
    dynamic medicine,
    MedicineController controller,
  ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusModernExtraLarge),
        ),
        elevation: DesignSystem.elevationHigh,
        child: _EditMedicineForm(
          medicine: medicine,
          controller: controller,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    dynamic medicine,
    MedicineController controller,
  ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignSystem.radiusModernExtraLarge),
        ),
        elevation: DesignSystem.elevationHigh,
        child: Padding(
          padding: DesignSystem.paddingBase,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_rounded,
                size: 50.sp,
                color: AppColors.warning,
              ),
              SizedBox(height: DesignSystem.base.h),
              Text(
                'delete_medicine'.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: DesignSystem.md.h),
              Text(
                'confirm_delete_medicine'
                    .trParams({'medicine': medicine.medicineName}),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: DesignSystem.lg.h),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      onPressed: Get.back,
                      label: 'cancel'.tr,
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.textPrimary,
                      style: app_button.ButtonStyle.outline,
                    ),
                  ),
                  SizedBox(width: DesignSystem.base.w),
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        controller.removeMedicine(medicine);
                        Get.back();
                        AppSnackBar.show(
                          context,
                          message: 'medicine_deleted'.tr,
                          type: SnackBarType.success,
                        );
                      },
                      label: 'delete'.tr,
                      backgroundColor: AppColors.error,
                      foregroundColor: AppColors.background,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// نموذج إضافة الدواء
class _AddMedicineForm extends StatefulWidget {
  const _AddMedicineForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final MedicineController controller;

  @override
  State<_AddMedicineForm> createState() => _AddMedicineFormState();
}

class _AddMedicineFormState extends State<_AddMedicineForm> {
  late TextEditingController nameController;
  late TextEditingController dosageController;
  String selectedType = 'Tablet';
  int selectedInterval = 1;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 85.h),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // عنوان النموذج مع أيقونة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withValues(alpha: 0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.medication_outlined,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'add_medicine'.tr,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'fill_medicine_details'.tr,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: Get.back,
                  icon: Icon(Icons.close, size: 24.sp),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 20.sp),

            // قسم المعلومات الأساسية
            _buildSectionTitle('basic_info'.tr, Icons.info_outline),
            SizedBox(height: 12.sp),

            _buildStyledTextField(
              controller: nameController,
              labelText: 'medicine_name'.tr,
              hintText: 'enter_medicine_name'.tr,
              icon: Icons.medication_outlined,
              iconColor: AppColors.primary,
            ),
            SizedBox(height: 12.sp),

            _buildStyledTextField(
              controller: dosageController,
              labelText: 'medicine_dosage'.tr,
              hintText: '500',
              icon: Icons.scale,
              iconColor: Colors.orange,
              keyboardType: TextInputType.number,
              suffixText: 'mg',
            ),
            SizedBox(height: 20.sp),

            // قسم نوع الدواء والتكرار
            _buildSectionTitle('medicine_settings'.tr, Icons.settings_outlined),
            SizedBox(height: 12.sp),

            _buildTypeDropdown(),
            SizedBox(height: 12.sp),

            _buildIntervalDropdown(),
            SizedBox(height: 24.sp),

            // أزرار الحفظ والإلغاء
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: Get.back,
                    label: 'cancel'.tr,
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.textSecondary,
                    style: app_button.ButtonStyle.outline,
                  ),
                ),
                SizedBox(width: 12.sp),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: AppButton(
                      onPressed: () {
                        if (nameController.text.isEmpty ||
                            dosageController.text.isEmpty) {
                          AppSnackBar.show(
                            context,
                            message: 'please_fill_all_fields'.tr,
                            type: SnackBarType.error,
                          );
                          return;
                        }

                        // Save medicine
                        // widget.controller.addMedicine(medicine);
                        Get.back();
                        AppSnackBar.show(
                          context,
                          message: 'medicine_added'.tr,
                          type: SnackBarType.success,
                        );
                      },
                      label: 'save'.tr,
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.sp,
        vertical: 8.sp,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.primary.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: AppColors.primary,
          ),
          SizedBox(width: 8.sp),
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    required Color iconColor,
    TextInputType? keyboardType,
    String? suffixText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: iconColor.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(12.sp),
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.sp,
            ),
          ),
          suffixText: suffixText,
          suffixStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.outline.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: iconColor.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    final typeColor = MedicineUtils.getMedicineTypeColor(selectedType);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: typeColor.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: -3,
          ),
        ],
        border: Border.all(
          color: AppColors.outline.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedType,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'medicine_type'.tr,
          labelStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(12.sp),
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              MedicineUtils.getMedicineTypeIcon(selectedType),
              color: typeColor,
              size: 20.sp,
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 14.sp,
          ),
        ),
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        dropdownColor: Colors.white,
        items: ['Pill', 'Tablet', 'Capsule', 'Liquid', 'Injection']
            .map((type) => DropdownMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Icon(
                        MedicineUtils.getMedicineTypeIcon(type),
                        color: MedicineUtils.getMedicineTypeColor(type),
                        size: 20.sp,
                      ),
                      SizedBox(width: 12.sp),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => selectedType = value);
          }
        },
      ),
    );
  }

  Widget _buildIntervalDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: -3,
          ),
        ],
        border: Border.all(
          color: AppColors.outline.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<int>(
        value: selectedInterval,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'medicine_frequency'.tr,
          labelStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(12.sp),
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.schedule_rounded,
              color: Colors.blue,
              size: 20.sp,
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 14.sp,
          ),
        ),
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        dropdownColor: Colors.white,
        items: [1, 2, 3, 4, 6, 8, 12, 24]
            .map((interval) => DropdownMenuItem(
                  value: interval,
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.blue.withValues(alpha: 0.7),
                        size: 18.sp,
                      ),
                      SizedBox(width: 12.sp),
                      Text(
                        MedicineUtils.formatFrequency(interval),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => selectedInterval = value);
          }
        },
      ),
    );
  }
}

/// نموذج تعديل الدواء
class _EditMedicineForm extends StatefulWidget {
  const _EditMedicineForm({
    Key? key,
    required this.medicine,
    required this.controller,
  }) : super(key: key);

  final dynamic medicine;
  final MedicineController controller;

  @override
  State<_EditMedicineForm> createState() => _EditMedicineFormState();
}

class _EditMedicineFormState extends State<_EditMedicineForm> {
  late TextEditingController nameController;
  late TextEditingController dosageController;
  late String selectedType;
  late int selectedInterval;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.medicine.medicineName);
    dosageController =
        TextEditingController(text: widget.medicine.dosage.toString());
    selectedType = widget.medicine.medicineType;
    selectedInterval = widget.medicine.interval;
  }

  @override
  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: DesignSystem.paddingBase,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // عنوان النموذج مع أيقونة
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(DesignSystem.sm),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignSystem.radiusSm),
                ),
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.orange,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: DesignSystem.base.w),
              Text(
                'edit_medicine'.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: DesignSystem.lg.h),

          // قسم المعلومات الأساسية
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: DesignSystem.md,
              vertical: DesignSystem.sm.h,
            ),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.05),
              border: Border(
                left: BorderSide(
                  color: Colors.orange,
                  width: 3,
                ),
              ),
              borderRadius: BorderRadius.circular(DesignSystem.radiusSm),
            ),
            child: Text(
              'basic_info'.tr,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: Colors.orange,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: DesignSystem.base.h),

          AppTextFormField(
            controller: nameController,
            labelText: 'medicine_name'.tr,
            prefixIcon: Icon(Icons.medication_outlined),
          ),
          SizedBox(height: DesignSystem.md.h),

          AppTextFormField(
            controller: dosageController,
            labelText: 'medicine_dosage'.tr,
            hintText: 'mg',
            prefixIcon: Icon(Icons.scale),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: DesignSystem.xxxl.h),

          // زر الحفظ (كامل العرض)
          AppButton(
            onPressed: () {
              Get.back();
              AppSnackBar.show(
                context,
                message: 'medicine_updated'.tr,
                type: SnackBarType.success,
              );
            },
            label: 'save'.tr,
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            width: double.infinity,
          ),
          SizedBox(height: DesignSystem.sm.h),
        ],
      ),
    );
  }
}