import 'dart:math';

import 'package:BetterMe/features/medicine/data/models/errors.dart';
import 'package:BetterMe/features/medicine/data/models/medicine.dart';
import 'package:BetterMe/features/medicine/data/models/medicine_type.dart';
import 'package:BetterMe/features/medicine/presentation/controllers/medicine_controller.dart';
import 'package:BetterMe/features/medicine/presentation/controllers/new_entry_controller.dart';
import 'package:BetterMe/features/medicine/presentation/pages/success_screen_view.dart';
import 'package:BetterMe/features/medicine/utils/convert_time.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:BetterMe/shared/widgets/buttons/app_button.dart' as app_button_widget;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NewEntryView extends StatefulWidget {
  final Medicine? medicineToEdit;
  final bool isEditing;

  const NewEntryView({
    super.key,
    this.medicineToEdit,
    this.isEditing = false,
  });

  @override
  State<NewEntryView> createState() => _NewEntryViewState();
}

class _NewEntryViewState extends State<NewEntryView> {
  late TextEditingController nameController;
  late TextEditingController dosageController;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late NewEntryController _newEntryController;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryController.dispose();
  }

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _newEntryController = Get.put(NewEntryController(), tag: 'new_entry_${DateTime.now().millisecondsSinceEpoch}');
    _scaffoldKey = GlobalKey<ScaffoldState>();

    // Load data if editing
    if (widget.isEditing && widget.medicineToEdit != null) {
      _loadMedicineData();
    }

    initializeNotifications();
    initializeErrorListen();
  }

  void _loadMedicineData() {
    final medicine = widget.medicineToEdit!;
    nameController.text = medicine.medicineName ?? '';
    dosageController.text = medicine.dosage?.toString() ?? '';

    // Set medicine type
    final type = _getMedicineTypeFromString(medicine.medicineType ?? 'Tablet');
    
    // Load all data at once
    _newEntryController.loadMedicineData(
      type: type,
      interval: medicine.interval ?? 0,
      startTime: medicine.startTime ?? 'none',
    );
  }

  MedicineType _getMedicineTypeFromString(String typeString) {
    return MedicineType.values.firstWhere(
      (type) => type.toString().substring(13) == typeString,
      orElse: () => MedicineType.Tablet,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MedicineController medicineController = Get.find<MedicineController>();
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignSystem.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Section
            _buildSectionHeader(
              'basic_info'.tr,
              Icons.info_outline,
            ),
            const SizedBox(height: 12),
            
            // Medicine Name Field
            _buildStyledTextField(
              controller: nameController,
              labelText: 'medicine_name'.tr,
              hintText: 'enter_medicine_name'.tr,
              prefixIcon: Icons.medication_outlined,
              iconColor: AppColors.primary,
              maxLength: 50,
              isRequired: true,
            ),
            const SizedBox(height: 16),
            
            // Dosage Field
            _buildStyledTextField(
              controller: dosageController,
              labelText: 'medicine_dosage'.tr,
              hintText: '500',
              prefixIcon: Icons.scale_outlined,
              iconColor: Colors.orange,
              keyboardType: TextInputType.number,
              maxLength: 12,
              suffixText: 'mg',
            ),
            const SizedBox(height: 20),
            
            // Medicine Settings Section
            _buildSectionHeader(
              'medicine_settings'.tr,
              Icons.settings_outlined,
            ),
            const SizedBox(height: 12),
            
            // Medicine Type Selector
            _buildMedicineTypeSelector(),
            const SizedBox(height: 20),
            
            // Frequency Selection
            _buildFrequencyLabel(),
            const SizedBox(height: 8),
            IntervalSelection(controller: _newEntryController),
            const SizedBox(height: 16),
            
            // Starting Time
            _buildTimeLabel(),
            const SizedBox(height: 8),
            SelectTime(controller: _newEntryController),
            const SizedBox(height: 24),
            
            // Action Buttons
            _buildActionButtons(medicineController, isMobile),
            const SizedBox(height: DesignSystem.base),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: DesignSystem.elevationMedium,
      title: Text(
        widget.isEditing ? 'edit_medicine'.tr : 'add_medicine'.tr,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.sp,
        vertical: 10.sp,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.sp),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencyLabel() {
    return Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          color: AppColors.primary,
          size: 18.sp,
        ),
        SizedBox(width: 8.sp),
        Text(
          'medicine_frequency'.tr,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          ' *',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.error,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeLabel() {
    return Row(
      children: [
        Icon(
          Icons.schedule_outlined,
          color: AppColors.primary,
          size: 18.sp,
        ),
        SizedBox(width: 8.sp),
        Text(
          'starting_time'.tr,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          ' *',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.error,
          ),
        ),
      ],
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    required Color iconColor,
    TextInputType? keyboardType,
    int? maxLength,
    String? suffixText,
    bool isRequired = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: iconColor.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          labelText: labelText + (isRequired ? ' *' : ''),
          labelStyle: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary.withValues(alpha: 0.6),
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              prefixIcon,
              color: iconColor,
              size: 20.sp,
            ),
          ),
          suffixText: suffixText,
          suffixStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: iconColor,
          ),
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
            borderSide: BorderSide(
              color: AppColors.outline.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
            borderSide: BorderSide(
              color: AppColors.outline.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
            borderSide: BorderSide(
              color: iconColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
            borderSide: BorderSide(
              color: AppColors.error,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
            borderSide: BorderSide(
              color: AppColors.error,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMedicineTypeSelector() {
    return Obx(() {
      final selectedType = _newEntryController.selectedMedicineType;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MedicineTypeColumn(
              controller: _newEntryController,
              medicineType: MedicineType.Bottle,
              name: 'type_bottle'.tr,
              iconValue: 'images/assets/icons/bottle.svg',
              isSelected: selectedType == MedicineType.Bottle,
            ),
            SizedBox(width: DesignSystem.base.w),
            MedicineTypeColumn(
              controller: _newEntryController,
              medicineType: MedicineType.Pill,
              name: 'type_pill'.tr,
              iconValue: 'images/assets/icons/pill.svg',
              isSelected: selectedType == MedicineType.Pill,
            ),
            SizedBox(width: DesignSystem.base.w),
            MedicineTypeColumn(
              controller: _newEntryController,
              medicineType: MedicineType.Syringe,
              name: 'type_syringe'.tr,
              iconValue: 'images/assets/icons/syringe.svg',
              isSelected: selectedType == MedicineType.Syringe,
            ),
            SizedBox(width: DesignSystem.base.w),
            MedicineTypeColumn(
              controller: _newEntryController,
              medicineType: MedicineType.Tablet,
              name: 'type_tablet'.tr,
              iconValue: 'images/assets/icons/tablet.svg',
              isSelected: selectedType == MedicineType.Tablet,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildActionButtons(
    MedicineController medicineController,
    bool isMobile,
  ) {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          flex: 1,
          child: AppButton(
            onPressed: () => Get.back(),
            label: 'cancel'.tr,
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textSecondary,
            height: 6.h,
            style: app_button_widget.ButtonStyle.outline,
          ),
        ),
        SizedBox(width: 12.sp),
        // Save Button with Shadow
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
              onPressed: () => _handleSave(medicineController),
              label: widget.isEditing ? 'update'.tr : 'save'.tr,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              height: 6.h,
              style: app_button_widget.ButtonStyle.solid,
            ),
          ),
        ),
      ],
    );
  }

  void _handleSave(MedicineController medicineController) {
    String? medicineName;
    int? dosage;

    // Validate medicine name
    if (nameController.text.isEmpty) {
      _newEntryController.submitError(EntryError.nameNull);
      return;
    }
    medicineName = nameController.text;

    // Validate dosage
    if (dosageController.text.isEmpty) {
      dosage = 0;
    } else {
      try {
        dosage = int.parse(dosageController.text);
      } catch (e) {
        _newEntryController.submitError(EntryError.dosage);
        return;
      }
    }

    // Check for duplicate (only if adding new)
    if (!widget.isEditing) {
      for (var medicine in medicineController.medicineList$) {
        if (medicineName == medicine.medicineName) {
          _newEntryController.submitError(EntryError.nameDuplicate);
          return;
        }
      }
    }

    // Validate interval
    if (_newEntryController.selectedInterval == 0) {
      _newEntryController.submitError(EntryError.interval);
      return;
    }

    // Validate start time
    if (_newEntryController.selectedTimeOfDay == 'none') {
      _newEntryController.submitError(EntryError.startTime);
      return;
    }

    String medicineType = _newEntryController.selectedMedicineType
        .toString()
        .substring(13);

    int interval = _newEntryController.selectedInterval;
    String startTime = _newEntryController.selectedTimeOfDay;

    if (widget.isEditing && widget.medicineToEdit != null) {
      // Update existing medicine
      final updatedMedicine = Medicine(
        notificationIDs: widget.medicineToEdit!.notificationIDs,
        medicineName: medicineName,
        dosage: dosage,
        medicineType: medicineType,
        interval: interval,
        startTime: startTime,
      );

      medicineController.updateMedicineByObject(
        widget.medicineToEdit!,
        updatedMedicine,
      );
      Get.back();
      AppSnackBar.show(
        context,
        message: 'medicine_updated'.tr,
        type: SnackBarType.success,
      );
    } else {
      // Add new medicine
      List<int> intIDs = makeIDs(24 / interval);
      List<String> notificationIDs = intIDs.map((i) => i.toString()).toList();

      Medicine newEntryMedicine = Medicine(
        notificationIDs: notificationIDs,
        medicineName: medicineName,
        dosage: dosage,
        medicineType: medicineType,
        interval: interval,
        startTime: startTime,
      );

      medicineController.addMedicine(newEntryMedicine);

      // Schedule notification
      final date = DateTime.now();
      scheduleNotification(newEntryMedicine, date);

      // Go to success screen and then back to medicine list
      Get.off(() => const SuccessScreenView());
    }
  }

  void initializeErrorListen() {
    // Listen to error state changes using GetX worker
    ever(_newEntryController.errorState$, (EntryError? error) {
      if (error != null) {
        switch (error) {
          case EntryError.nameNull:
            displayError('error_medicine_name_required'.tr);
            break;
          case EntryError.nameDuplicate:
            displayError('error_medicine_exists'.tr);
            break;
          case EntryError.dosage:
            displayError('error_dosage_invalid'.tr);
            break;
          case EntryError.interval:
            displayError('error_interval_required'.tr);
            break;
          case EntryError.startTime:
            displayError('error_start_time_required'.tr);
            break;
          default:
        }
        // Clear error after showing
        _newEntryController.clearError();
      }
    });
  }

  void displayError(String error) {
    AppSnackBar.show(
      context,
      message: error,
      type: SnackBarType.error,
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n.toInt(); i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }

  initializeNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_healing');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    Get.offAllNamed('/');
  }

  Future<void> scheduleNotification(Medicine medicine, DateTime date) async {
    var hour = int.parse(medicine.startTime![0] + medicine.startTime![1]);
    var ogValue = hour;
    var minute = int.parse(medicine.startTime![2] + medicine.startTime![3]);

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      importance: Importance.max,
      ledColor: Color(0xFFBBE5A9),
      ledOffMs: 1000,
      priority: Priority.high,
      ledOnMs: 1000,
      enableLights: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    for (int i = 0; i < (24 / medicine.interval!).floor(); i++) {
      if (hour + (medicine.interval! * i) > 23) {
        hour = hour + (medicine.interval! * i) - 24;
      } else {
        hour = hour + (medicine.interval! * i);
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse(medicine.notificationIDs![i]),
        'reminder'.tr + ': ${medicine.medicineName}',
        medicine.medicineType.toString() != MedicineType.None.toString()
            ? 'take_medicine_reminder'
                .trParams({'type': medicine.medicineType!.toLowerCase()})
            : 'take_medicine_reminder_default'.tr,
        tz.TZDateTime.now(tz.local).add(
          Duration(
            hours: hour - date.hour,
            minutes: minute - date.minute,
          ),
        ),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      hour = ogValue;
    }
  }
}

class SelectTime extends StatefulWidget {
  final NewEntryController controller;
  
  const SelectTime({super.key, required this.controller});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        widget.controller.updateTime(convertTime(_time.hour.toString()) +
            convertTime(_time.minute.toString()));
      });
    }
    return picked ?? _time;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectTime(),
          borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
          child: Container(
            height: 7.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _clicked ? Icons.access_time_filled : Icons.access_time_outlined,
                  color: Colors.white,
                  size: 22.sp,
                ),
                SizedBox(width: 12.sp),
                Text(
                  _clicked
                      ? "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}"
                      : 'select_time'.tr,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  final NewEntryController controller;
  
  const IntervalSelection({super.key, required this.controller});

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: 14.sp,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.outline.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.repeat_rounded,
                color: AppColors.primary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.sp),
            Text(
              'remind_me_every'.tr,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: DropdownButton<int>(
                isExpanded: true,
                underline: const SizedBox(),
                iconEnabledColor: AppColors.primary,
                dropdownColor: Colors.white,
                itemHeight: null,
                hint: Text(
                  'select_interval'.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                elevation: 8,
                value: _selected == 0 ? null : _selected,
                items: _intervals.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8.sp),
                        Text(
                          '$value ${'hours'.tr}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newVal) {
                  if (newVal != null) {
                    setState(() {
                      _selected = newVal;
                      widget.controller.updateInterval(newVal);
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn({
    super.key,
    required this.controller,
    required this.medicineType,
    required this.name,
    required this.iconValue,
    required this.isSelected,
  });

  final NewEntryController controller;
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.updateSelectedMedicine(medicineType);
      },
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18.w,
              constraints: const BoxConstraints(
                minWidth: 50,
                maxWidth: 100,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                color: isSelected ? AppColors.primary : AppColors.surface,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.outline,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: DesignSystem.base,
                ),
                child: SvgPicture.asset(
                  iconValue,
                  height: 6.h,
                  color: isSelected ? Colors.white : AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: DesignSystem.sm.h),
            SizedBox(
              width: 18.w,
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}