# 🔧 التوثيق التقني - نموذج إضافة وتعديل الدواء

## 📚 نظرة عامة على البنية

```
┌─────────────────────────────────────────────────────┐
│ NewEntryView (StatefulWidget)                       │
├─────────────────────────────────────────────────────┤
│ ├─ _NewEntryViewState                              │
│ │  ├─ Controllers                                  │
│ │  │  ├─ nameController: TextEditingController    │
│ │  │  ├─ dosageController: TextEditingController  │
│ │  │  └─ _newEntryBloc: NewEntryBloc             │
│ │  ├─ Methods                                      │
│ │  │  ├─ _loadMedicineData()                      │
│ │  │  ├─ _handleSave()                            │
│ │  │  ├─ _buildSectionHeader()                    │
│ │  │  └─ _buildActionButtons()                    │
│ │  └─ Build                                        │
│ │     ├─ AppBar                                    │
│ │     └─ SingleChildScrollView                    │
│ │        └─ Column (Form Fields)                  │
│ ├─ SelectTime (StatefulWidget)                    │
│ ├─ IntervalSelection (StatefulWidget)             │
│ └─ MedicineTypeColumn (StatelessWidget)           │
└─────────────────────────────────────────────────────┘
```

---

## 🎛️ الحالات (States)

### 1. **إضافة دواء جديد**
```dart
NewEntryView()
↓
تحميل النموذج الفارغ
↓
إدخال البيانات
↓
الضغط على "Save"
↓
التحقق من الصحة
↓
حفظ في MedicineController
↓
جدولة التنبيهات
↓
الانتقال لـ SuccessScreenView
```

### 2. **تعديل دواء موجود**
```dart
NewEntryView(medicineToEdit: medicine, isEditing: true)
↓
تحميل بيانات الدواء (initState)
↓
ملء الحقول تلقائياً
↓
تعديل البيانات
↓
الضغط على "Update"
↓
التحقق من الصحة
↓
استدعاء updateMedicineByObject()
↓
رسالة نجاح
↓
الرجوع للقائمة
```

---

## 📊 تدفق البيانات (Data Flow)

### المسار: الإضافة

```
User Input
   ↓
TextEditingControllers
   ↓
_handleSave() Validation
   ↓
Create Medicine Object
   ↓
medicineController.addMedicine()
   ↓
Save to SharedPreferences
   ↓
Schedule Notifications
   ↓
Update medicineList$ (RxList)
   ↓
UI Updates Automatically
```

### المسار: التعديل

```
Select Medicine
   ↓
Get.to(NewEntryView(...))
   ↓
_loadMedicineData()
   ↓
Load into Controllers
   ↓
User Edits
   ↓
_handleSave() Validation
   ↓
Create Updated Medicine
   ↓
updateMedicineByObject()
   ↓
Save to SharedPreferences
   ↓
UI Updates (medicine_list_page)
```

---

## 🛡️ معالجة الأخطاء

### Validation Chain

```dart
┌─────────────────────────────┐
│ Name Empty?                 │ → EntryError.nameNull
├─────────────────────────────┤
│ Dosage Invalid?             │ → EntryError.dosage
├─────────────────────────────┤
│ Medicine Duplicate?         │ → EntryError.nameDuplicate
├─────────────────────────────┤
│ Interval Not Selected?      │ → EntryError.interval
├─────────────────────────────┤
│ Start Time Not Selected?    │ → EntryError.startTime
├─────────────────────────────┤
│ ✅ All Valid               │ → Proceed to Save
└─────────────────────────────┘
```

### Error Handling Flow

```dart
_newEntryBloc.submitError(error)
   ↓
errorState$.listen()
   ↓
switch(error)
   ├─ nameNull → "يرجى إدخال اسم الدواء"
   ├─ nameDuplicate → "هذا الدواء موجود بالفعل"
   ├─ dosage → "الجرعة غير صحيحة"
   ├─ interval → "يرجى اختيار الفترة الزمنية"
   └─ startTime → "يرجى اختيار وقت البداية"
   ↓
displayError()
   ↓
AppSnackBar.show()
```

---

## 📦 البيانات الرئيسية

### Medicine Object

```dart
class Medicine {
  String? medicineName;      // e.g., "Aspirin"
  int? dosage;               // e.g., 500 (mg)
  String? medicineType;      // e.g., "Tablet"
  int? interval;             // e.g., 8 (hours)
  String? startTime;         // e.g., "08:00"
  List<String>? notificationIDs; // للتنبيهات
}
```

### MedicineType Enum

```dart
enum MedicineType {
  Bottle,   // زجاجة
  Pill,     // حبة
  Syringe,  // حقنة
  Tablet,   // قرص
  None      // لا شيء
}
```

---

## 🎨 مكونات الواجهة

### 1. AppBar
```dart
AppBar(
  backgroundColor: AppColors.primary,
  title: Text(widget.isEditing ? 'edit_medicine'.tr : 'add_medicine'.tr),
  centerTitle: true,
  leading: IconButton(onPressed: () => Get.back())
)
```

### 2. Form Sections

```dart
// القسم الأول: اسم الدواء
_buildSectionHeader('medicine_name'.tr, true)
AppTextFormField(...)

// القسم الثاني: الجرعة
_buildSectionHeader('medicine_dosage'.tr, false)
AppTextFormField(...)

// القسم الثالث: النوع
_buildSectionHeader('type'.tr, false)
_buildMedicineTypeSelector()

// القسم الرابع: الفترة
_buildSectionHeader('medicine_frequency'.tr, true)
IntervalSelection()

// القسم الخامس: الوقت
_buildSectionHeader('starting_time'.tr, true)
SelectTime()
```

### 3. Action Buttons

```dart
_buildActionButtons()
  ├─ AppButton (Save/Update) → Primary Color
  └─ AppButton (Cancel) → Outline Style
```

---

## 🔄 التفاعل مع الـ Provider و GetX

### Provider استخدام

```dart
// توفير NewEntryBloc
Provider<NewEntryBloc>.value(
  value: _newEntryBloc,
  child: Child,
)

// استخدامه في Sub-widgets
final bloc = Provider.of<NewEntryBloc>(context)
```

### GetX استخدام

```dart
// الوصول للمتحكم
final medicineController = Get.find<MedicineController>()

// التنقل
Get.to(() => const NewEntryView())

// الحوارات
Get.dialog(...)

// الرجوع
Get.back()
Get.offAllNamed('/')
```

---

## 📱 Responsive Implementation

### Breakpoints

```dart
// Mobile Phone
width < 600px
  ├─ Full width fields (100%)
  └─ Vertical stack buttons

// Tablet
600px ≤ width < 900px
  ├─ Optimized spacing
  └─ Better layout

// Large Screens
width ≥ 900px
  ├─ Wider containers
  └─ More padding
```

### Widget Sizing

```dart
// Dynamic sizing
- width: double.infinity      // 100% width
- height: 6.h                 // 6% of height
- maxLength: 50               // Max chars
- constraints: BoxConstraints()

// Sizer Package
- h → percentage of height
- w → percentage of width
- sp → scaled font size
```

### ScrollView Management

```dart
SingleChildScrollView(
  padding: EdgeInsets.all(DesignSystem.base),
  child: Column(
    // يسمح بالتمرير عند ظهور keyboard
  ),
)
```

---

## 🌍 نظام الترجمة

### Implementation

```dart
// في app_localizations.dart
'medicine_name': 'اسم الدواء',        // Arabic
'medicine_name': 'Medicine Name',    // English

// الاستخدام
Text('medicine_name'.tr)

// مع المعاملات
'confirm_delete'.trParams({'item': medicine})
```

### المفاتيح الأساسية

```dart
// UI Elements
'add_medicine', 'edit_medicine', 'update', 'save', 'cancel'

// Form Fields
'medicine_name', 'medicine_dosage', 'type', 'starting_time'

// Options
'type_bottle', 'type_pill', 'type_syringe', 'type_tablet'
'remind_me_every', 'select_interval', 'hours', 'select_time'

// Errors
'error_medicine_name_required', 'error_medicine_exists'
'error_dosage_invalid', 'error_interval_required'
'error_start_time_required'

// Success
'medicine_updated_successfully', 'medicine_added_successfully'
```

---

## 🔔 نظام التنبيهات

### Scheduling Logic

```dart
// For each interval in 24 hours:
// ├─ 0:00 → startTime + 0 * interval
// ├─ 0:00 → startTime + 1 * interval
// ├─ 0:00 → startTime + 2 * interval
// └─ ...

for (int i = 0; i < (24 / interval).floor(); i++) {
  var notificationTime = startTime + (i * interval)
  
  await flutterLocalNotificationsPlugin.zonedSchedule(
    notificationID,
    'reminder'.tr + ': ' + medicineName,
    'take_medicine_reminder'.trParams({'type': medicineType}),
    tzDateTime,
    platformChannelSpecifics,
  )
}
```

### Notification Parameters

```dart
- ID: Generated random number (1-1000000000)
- Title: "تنبيه: اسم الدواء"
- Body: "حان وقت تناول الدواء"
- Time: Calculated based on interval
- Repeat: Not set (one-time notifications)
```

---

## 📦 MedicineController Methods

### الدوال الرئيسية

```dart
// إضافة دواء
Future<void> addMedicine(Medicine medicine)

// تحديث بـ Object
Future<void> updateMedicineByObject(
  Medicine oldMedicine,
  Medicine newMedicine
)

// تحديث بـ Index
Future<void> updateMedicine(int index, Medicine medicine)

// حذف
Future<void> removeMedicine(Medicine medicine)
Future<void> removeMedicineAt(int index)

// تحميل
Future<void> loadMedicines()

// حفظ
Future<void> _saveMedicinesToStorage()

// إلغاء تنبيهات
Future<void> _cancelNotifications(Medicine medicine)
```

---

## 🎯 أفضل الممارسات

### ✅ ما يتم اتباعه:

1. **Clean Architecture**
   ```dart
   // Separation of concerns
   - Views (Pages)
   - Controllers (Business Logic)
   - Models (Data)
   ```

2. **State Management**
   ```dart
   // GetX + Provider
   - GetX: Navigation & Global State
   - Provider: Local Widget State
   - RxList: Reactive lists
   ```

3. **Design System**
   ```dart
   // Consistent styling
   - AppColors for all colors
   - DesignSystem for spacing/sizing
   - Unified widget components
   ```

4. **Error Handling**
   ```dart
   // Proper validation
   - Input validation
   - Error callbacks
   - User-friendly messages
   ```

5. **Localization**
   ```dart
   // Multi-language support
   - All texts use .tr
   - Arabic & English support
   - Dynamic language switching
   ```

---

## 🧪 Unit Testing Example

```dart
test('Medicine validation - empty name', () {
  final controller = TextEditingController();
  final bloc = NewEntryBloc();
  
  // Simulate saving with empty name
  // Expect: EntryError.nameNull
  
  expect(
    bloc.errorState$,
    emits(EntryError.nameNull),
  );
});

test('Medicine duplicate check', () {
  final existingMedicine = Medicine(
    medicineName: 'Aspirin',
    // ...
  );
  
  // Try to add same medicine
  // Expect: EntryError.nameDuplicate
  
  expect(
    bloc.errorState$,
    emits(EntryError.nameDuplicate),
  );
});
```

---

## 🚀 Performance Considerations

### ✅ Optimizations:

1. **Memory**
   - Dispose controllers in dispose()
   - Unsubscribe from streams
   - Remove listeners

2. **UI Rendering**
   - Use const constructors
   - Avoid unnecessary rebuilds
   - StreamBuilder for reactive updates

3. **Storage**
   - SharedPreferences for local data
   - JSON serialization/deserialization
   - Async operations

4. **Notifications**
   - Random unique IDs
   - Efficient scheduling
   - Timezone handling

---

## 🐛 Common Issues & Solutions

| المشكلة | السبب | الحل |
|--------|------|-----|
| لا تظهر الحقول | عدم استخدام Scroll | استخدم SingleChildScrollView |
| الزر مخفي | عدم التعامل مع keyboard | استخدم resizeToAvoidBottomInset |
| لا تعمل الترجمة | مفتاح غير موجود | أضفه في app_localizations.dart |
| لا تُحفظ البيانات | عدم استدعاء save | تحقق من _saveMedicinesToStorage() |
| لا تظهر الرسائل | عدم الاستماع للأخطاء | تحقق من initializeErrorListen() |

---

## 📞 الدعم والصيانة

### في حالة المشاكل:

1. تحقق من Logs:
   ```bash
   flutter logs
   ```

2. اختبر الـ Analyzer:
   ```bash
   flutter analyze
   ```

3. أعد البناء:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

---

**آخر تحديث**: 2025-01-04  
**الإصدار**: 1.0  
**الحالة**: ✅ اكتمل