# Medicine Widgets Documentation

## 🎯 Overview

مجموعة من الـ Widgets المتخصصة لإدارة واجهات الأدوية في تطبيق BetterMe. جميع الـ Widgets مصممة لكي تكون:
- ✅ قابلة لإعادة الاستخدام
- ✅ Responsive على جميع الأحجام
- ✅ متوافقة مع DesignSystem
- ✅ مدعومة بـ Localization

---

## 📦 الـ Widgets المتاحة

### 1. MedicineCard

بطاقة تعرض معلومات الدواء بشكل منظم.

#### الاستخدام:
```dart
import 'package:BetterMe/shared/widgets/medicine/index.dart';

MedicineCard(
  medicineName: 'Aspirin',
  dosage: '500mg',
  medicineType: 'Tablet',
  frequency: 'Every 8 hours',
  status: 'pending',  // 'taken', 'missed', 'pending'
  nextDose: '3:00 PM',  // Optional
  backgroundColor: AppColors.background,  // Optional
  onTap: () => print('Card tapped'),
  onEdit: () => print('Edit tapped'),
  onDelete: () => print('Delete tapped'),
)
```

#### الخصائص:
| الخاصية | النوع | المطلوبة | الوصف |
|--------|-------|---------|--------|
| medicineName | String | ✅ | اسم الدواء |
| dosage | String | ✅ | جرعة الدواء |
| medicineType | String | ✅ | نوع الدواء (Pill, Tablet, ...) |
| frequency | String | ✅ | تكرار الدواء |
| status | String | ❌ | حالة الدواء (default: 'pending') |
| nextDose | String? | ❌ | وقت الجرعة التالية |
| icon | IconData? | ❌ | أيقونة مخصصة |
| onTap | VoidCallback? | ❌ | عند النقر على البطاقة |
| onEdit | VoidCallback? | ❌ | عند النقر على تعديل |
| onDelete | VoidCallback? | ❌ | عند النقر على حذف |
| backgroundColor | Color? | ❌ | لون الخلفية |

#### الألوان حسب الحالة:
- **taken** ✅ أخضر (AppColors.success)
- **missed** ❌ أحمر (AppColors.error)
- **pending** ⏱️ برتقالي (AppColors.warning)

---

### 2. EmptyMedicineState

واجهة جميلة تظهر عند عدم وجود أدوية.

#### الاستخدام:
```dart
EmptyMedicineState(
  onAddPressed: () => print('Add tapped'),
  title: 'no_medicines',  // Translation key
  subtitle: 'add_first_medicine',  // Translation key
  actionButtonText: 'add',  // Translation key
)
```

#### الخصائص:
| الخاصية | النوع | المطلوبة | الوصف |
|--------|-------|---------|--------|
| onAddPressed | VoidCallback? | ❌ | عند النقر على الزر |
| title | String | ❌ | مفتاح العنوان المترجم |
| subtitle | String | ❌ | مفتاح النص الفرعي |
| actionButtonText | String | ❌ | مفتاح نص الزر |

---

### 3. MedicineActionButtons

أزرار إجراءات (تعديل، حذف، وضع كمأخوذ).

#### الاستخدام:
```dart
MedicineActionButtons(
  onMarkTaken: () => print('Marked as taken'),
  onEdit: () => print('Edit'),
  onDelete: () => print('Delete'),
  isTaken: false,  // يتحكم في لون زر 'Mark as Taken'
)
```

#### الخصائص:
| الخاصية | النوع | المطلوبة | الوصف |
|--------|-------|---------|--------|
| onMarkTaken | VoidCallback? | ❌ | وضع كمأخوذ |
| onEdit | VoidCallback? | ❌ | تعديل |
| onDelete | VoidCallback? | ❌ | حذف |
| isTaken | bool | ❌ | إذا كان مأخوذاً (default: false) |

---

### 4. MedicineInfoItem

عنصر يعرض معلومة واحدة عن الدواء (في الـ Details).

#### الاستخدام:
```dart
MedicineInfoItem(
  label: 'medicine_name',
  value: 'Aspirin',
  icon: Icons.medication_outlined,
  backgroundColor: AppColors.background,
)
```

#### الخصائص:
| الخاصية | النوع | المطلوبة | الوصف |
|--------|-------|---------|--------|
| label | String | ✅ | تسمية المعلومة |
| value | String | ✅ | القيمة |
| icon | IconData? | ❌ | الأيقونة |
| backgroundColor | Color? | ❌ | لون الخلفية |

---

### 5. MedicineReminderBanner

بنر تنبيه لوقت تناول الدواء.

#### الاستخدام:
```dart
MedicineReminderBanner(
  medicineName: 'Aspirin',
  dosage: '500mg',
  nextTime: '3:00 PM',
  onDismiss: () => print('Dismissed'),
  onTakeMedicine: () => print('Marked as taken'),
)
```

#### الخصائص:
| الخاصية | النوع | المطلوبة | الوصف |
|--------|-------|---------|--------|
| medicineName | String | ✅ | اسم الدواء |
| dosage | String | ✅ | الجرعة |
| nextTime | String | ✅ | وقت الجرعة التالية |
| onDismiss | VoidCallback? | ❌ | إغلاق التنبيه |
| onTakeMedicine | VoidCallback? | ❌ | وضع كمأخوذ |

---

## 🔧 Helper Utilities

### المسار: `lib/shared/utils/medicine_utils.dart`

#### الدوال المتاحة:

##### 1. getMedicineTypeIcon(String medicineType)
الحصول على الأيقونة الصحيحة لنوع الدواء.

```dart
IconData icon = MedicineUtils.getMedicineTypeIcon('pill');
// النتيجة: Icons.circle_outlined

// الأنواع المدعومة:
// 'pill' / 'حبة' → Icons.circle_outlined
// 'tablet' / 'قرص' → Icons.rectangle_outlined
// 'capsule' / 'كبسولة' → Icons.grain
// 'liquid' / 'سائل' → Icons.local_drink_outlined
// 'injection' / 'حقنة' → Icons.medical_services_outlined
// 'syrup' / 'شراب' → Icons.water_drop_outlined
// 'cream' / 'كريم' → Icons.palette_outlined
```

##### 2. getMedicineTypeColor(String medicineType)
الحصول على اللون المناسب لنوع الدواء.

```dart
Color color = MedicineUtils.getMedicineTypeColor('pill');
// النتيجة: Color من AppColors
```

##### 3. formatFrequency(int interval)
تنسيق التكرار بصيغة مقروءة.

```dart
String freq = MedicineUtils.formatFrequency(1);
// النتيجة: 'كل ساعة' / 'Every hour'

String freq = MedicineUtils.formatFrequency(8);
// النتيجة: 'كل 8 ساعات' / 'Every 8 hours'
```

##### 4. getStatusText(String status)
الحصول على نص الحالة المترجم.

```dart
String text = MedicineUtils.getStatusText('taken');
// النتيجة: 'تم تناوله' / 'Taken'
```

##### 5. getStatusColor(String status)
الحصول على لون الحالة.

```dart
Color color = MedicineUtils.getStatusColor('taken');
// النتيجة: AppColors.success (أخضر)
```

##### 6. getStatusIcon(String status)
الحصول على أيقونة الحالة.

```dart
IconData icon = MedicineUtils.getStatusIcon('pending');
// النتيجة: Icons.schedule
```

##### 7. formatNextDoseTime(DateTime? nextTime)
تنسيق وقت الجرعة التالية.

```dart
String time = MedicineUtils.formatNextDoseTime(DateTime.now().add(Duration(hours: 3)));
// النتيجة: 'الجرعة القادمة: 3 ساعات' / 'Next Dose: 3 hours'
```

##### 8. shouldShowReminder(DateTime reminderTime)
التحقق من ما إذا كان يجب عرض التنبيه (ضمن 30 دقيقة).

```dart
bool show = MedicineUtils.shouldShowReminder(reminderTime);
```

##### 9. getMedicineTypes()
قائمة أنواع الأدوية المترجمة.

```dart
List<String> types = MedicineUtils.getMedicineTypes();
// النتيجة: ['حبة', 'قرص', 'كبسولة', 'سائل', 'حقنة', 'شراب', 'كريم']
```

##### 10. getFrequencyOptions()
قائمة خيارات التكرار.

```dart
List<Map<String, dynamic>> options = MedicineUtils.getFrequencyOptions();
// النتيجة: 
// [
//   {'value': 1, 'label': 'كل ساعة'},
//   {'value': 2, 'label': 'مرتان'},
//   ...
// ]
```

---

## 🎨 Color Scheme

```dart
// الحالات
AppColors.success    // أخضر ✅ (Taken)
AppColors.error      // أحمر ❌ (Missed)
AppColors.warning    // برتقالي ⏱️ (Pending)

// الأساسية
AppColors.primary         // أخضر #7CBD43
AppColors.secondary       // بنفسجي #8B7FBD
AppColors.background      // أبيض #FFFFFF
AppColors.surface         // رمادي فاتح #F8F9FA

// النصوص
AppColors.textPrimary     // نص أساسي
AppColors.textSecondary   // نص فرعي
AppColors.textTertiary    // نص ثالثي

// الحدود
AppColors.outline         // حدود
AppColors.outlineVariant  // حدود فاتحة
```

---

## 📏 Responsive Sizes

جميع الأحجام تدعم الأجهزة المختلفة:

```dart
// عرض
16.w    // 16% من عرض الشاشة

// ارتفاع
8.h     // 8% من ارتفاع الشاشة

// حجم الخط
14.sp   // 14 Scalable Points
```

---

## 🌍 Localization

جميع النصوص مدعومة بـ localization:

```dart
'my_medicines'.tr             // أدويتي / My Medicines
'medicine_name'.tr            // اسم الدواء / Medicine Name
'medicine_dosage'.tr          // جرعة الدواء / Medicine Dosage
'medicine_frequency'.tr       // عدد مرات التناول / Frequency
'mark_as_taken'.tr            // وضّع كمأخوذ / Mark as Taken
'edit_medicine'.tr            // تعديل الدواء / Edit Medicine
'delete_medicine'.tr          // حذف الدواء / Delete Medicine
'confirm_delete_medicine'.tr  // تأكيد الحذف / Confirm Delete
```

---

## 💡 أمثلة الاستخدام

### مثال 1: عرض قائمة أدوية

```dart
ListView.builder(
  itemCount: medicines.length,
  itemBuilder: (context, index) {
    final medicine = medicines[index];
    return MedicineCard(
      medicineName: medicine.name,
      dosage: '${medicine.dosage} mg',
      medicineType: medicine.type,
      frequency: MedicineUtils.formatFrequency(medicine.interval),
      onEdit: () => _editMedicine(medicine),
      onDelete: () => _deleteMedicine(medicine),
    );
  },
)
```

### مثال 2: عرض تفاصيل الدواء

```dart
Column(
  children: [
    MedicineInfoItem(
      label: 'medicine_name'.tr,
      value: medicine.name,
      icon: Icons.medication_outlined,
    ),
    MedicineInfoItem(
      label: 'medicine_dosage'.tr,
      value: '${medicine.dosage} mg',
      icon: Icons.scale,
    ),
    MedicineInfoItem(
      label: 'medicine_frequency'.tr,
      value: MedicineUtils.formatFrequency(medicine.interval),
      icon: Icons.schedule,
    ),
  ],
)
```

### مثال 3: عرض تنبيه

```dart
if (reminderTime != null && MedicineUtils.shouldShowReminder(reminderTime)) {
  MedicineReminderBanner(
    medicineName: medicine.name,
    dosage: '${medicine.dosage} mg',
    nextTime: DateFormat('hh:mm a').format(reminderTime),
    onTakeMedicine: () => markAsTaken(medicine),
    onDismiss: () => dismissReminder(),
  )
}
```

---

## ✅ Checklist للمطورين

عند إضافة ميزة جديدة:

- [ ] استخدام `MedicineCard` للعرض
- [ ] استخدام `MedicineUtils` للدوال المساعدة
- [ ] إضافة النصوص في `app_localizations.dart`
- [ ] استخدام DesignSystem للأبعاد
- [ ] استخدام AppColors للألوان
- [ ] دعم Responsive Design
- [ ] اختبار على أحجام مختلفة
- [ ] اختبار اللغات (العربية والإنجليزية)

---

## 🚀 Performance Tips

1. **استخدم Obx من GetX** لتحديث البيانات فقط عند التغيير
2. **تجنب rebuilds غير الضرورية** باستخدام const constructors
3. **استخدم المتغيرات المحلية** بدلاً من الحسابات المتكررة
4. **استخدم ListView.builder** للقوائم الطويلة

---

## 📞 الدعم والأسئلة

للمزيد من الأسئلة، راجع:
- `MEDICINE_IMPROVEMENTS_COMPLETE.md` - التوثيق الشامل
- `app_localizations.dart` - النصوص المترجمة
- `medicine_utils.dart` - الدوال المساعدة

---

**آخر تحديث**: 2024
**الإصدار**: 1.0.0