import 'package:BetterMe/features/medicine/data/models/errors.dart';
import 'package:BetterMe/features/medicine/data/models/medicine_type.dart';
import 'package:get/get.dart';

/// NewEntryController - GetX replacement for NewEntryBloc
/// Manages state for adding/editing medicine entries
class NewEntryController extends GetxController {
  // Observable states (Reactive)
  final Rx<MedicineType> _selectedMedicineType = MedicineType.None.obs;
  final RxInt _selectedInterval = 0.obs;
  final RxString _selectedTimeOfDay = 'none'.obs;
  final Rx<EntryError?> _errorState = Rx<EntryError?>(null);

  // Getters for external access
  MedicineType get selectedMedicineType => _selectedMedicineType.value;
  int get selectedInterval => _selectedInterval.value;
  String get selectedTimeOfDay => _selectedTimeOfDay.value;
  EntryError? get errorState => _errorState.value;

  // Reactive getters for Obx widgets
  Rx<MedicineType> get selectedMedicineType$ => _selectedMedicineType;
  RxInt get selectedInterval$ => _selectedInterval;
  RxString get selectedTimeOfDay$ => _selectedTimeOfDay;
  Rx<EntryError?> get errorState$ => _errorState;

  @override
  void onInit() {
    super.onInit();
    // Initialize default values
    _selectedMedicineType.value = MedicineType.None;
    _selectedTimeOfDay.value = 'none';
    _selectedInterval.value = 0;
    _errorState.value = null;
  }

  @override
  void onClose() {
    // GetX handles disposal automatically
    super.onClose();
  }

  /// Submit error state
  void submitError(EntryError error) {
    _errorState.value = error;
  }

  /// Clear error state
  void clearError() {
    _errorState.value = null;
  }

  /// Update selected interval
  void updateInterval(int interval) {
    _selectedInterval.value = interval;
  }

  /// Update selected time of day
  void updateTime(String time) {
    _selectedTimeOfDay.value = time;
  }

  /// Update selected medicine type (toggle behavior)
  void updateSelectedMedicine(MedicineType type) {
    if (type == _selectedMedicineType.value) {
      _selectedMedicineType.value = MedicineType.None;
    } else {
      _selectedMedicineType.value = type;
    }
  }

  /// Reset all fields to default
  void resetForm() {
    _selectedMedicineType.value = MedicineType.None;
    _selectedInterval.value = 0;
    _selectedTimeOfDay.value = 'none';
    _errorState.value = null;
  }

  /// Load existing medicine data for editing
  void loadMedicineData({
    required MedicineType type,
    required int interval,
    required String startTime,
  }) {
    _selectedMedicineType.value = type;
    _selectedInterval.value = interval;
    _selectedTimeOfDay.value = startTime;
  }
}