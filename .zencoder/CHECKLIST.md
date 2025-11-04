# ✅ Checklist التحسينات - مشروع BetterMe

## 📌 قبل البدء
- [ ] عمل Backup كامل للمشروع
- [ ] إنشاء Git branch: `git checkout -b refactoring/cleanup`
- [ ] التأكد من عمل المشروع: `flutter run`
- [ ] حفظ نسخة من pubspec.yaml

---

## 🔥 المرحلة 1: التنظيف (Priority: HIGH)

### A. حذف الملفات الفارغة/غير المستخدمة
- [ ] حذف `lib/app/my_app_controller.dart`
- [ ] Git commit: `"chore: remove empty files"`

### B. حذف Widgets المكررة من core/widgets
- [ ] استبدال `CustomText` بـ `AppText`
- [ ] استبدال `CustomToast` بـ `AppSnackBar`
- [ ] حذف `custom_text_form_field.dart`
- [ ] حذف `navigation_bar.dart`
- [ ] حذف `faq_item.dart`
- [ ] حذف المجلد `lib/core/widgets/` بالكامل
- [ ] Git commit: `"refactor: unify widgets in shared/widgets"`

### C. تحويل BLoC إلى GetX
- [ ] إنشاء `NewEntryController extends GetxController`
- [ ] تحديث `new_entry_view.dart`
- [ ] حذف استيراد Provider
- [ ] حذف استيراد RxDart
- [ ] استبدال StreamBuilder بـ Obx
- [ ] حذف `new_entry_bloc.dart`
- [ ] Git commit: `"refactor: convert BLoC to GetX"`

### D. حذف Dependencies غير المستخدمة
- [ ] حذف `provider: ^6.0.0` من pubspec.yaml
- [ ] حذف `rxdart: ^0.27.7` من pubspec.yaml
- [ ] تشغيل `flutter pub get`
- [ ] Git commit: `"chore: remove unused dependencies"`

### E. اختبار شامل
- [ ] `flutter clean && flutter pub get`
- [ ] `flutter analyze`
- [ ] `flutter run` - التأكد من عمل كل شيء
- [ ] اختبار جميع الـ Features
- [ ] Git commit: `"chore: Phase 1 complete ✅"`

---

## 🎨 المرحلة 2: تحسين UI (Priority: MEDIUM)

### A. استبدال Hard-coded Values
- [ ] استبدال `EdgeInsets.all(16)` بـ `DesignSystem.paddingBase`
- [ ] استبدال `BorderRadius.circular(12)` بـ `DesignSystem.borderRadiusMd`
- [ ] استبدال الألوان الثابتة بـ `AppColors.*`
- [ ] Git commit: `"refactor: use DesignSystem constants"`

### B. إضافة const
- [ ] إضافة const للـ SizedBox
- [ ] إضافة const للـ EdgeInsets
- [ ] إضافة const للـ Icons
- [ ] إضافة const للـ Text Styles
- [ ] Git commit: `"perf: add const keywords"`

### C. توحيد Text Styles
- [ ] استخدام `AppText` في كل مكان
- [ ] استخدام `AppText.heading1/2/3`
- [ ] استخدام `AppText.bodyLarge/Medium/Small`
- [ ] Git commit: `"refactor: unify text styles"`

### D. اختبار
- [ ] `flutter analyze`
- [ ] اختبار UI على جميع الشاشات
- [ ] Git commit: `"chore: Phase 2 complete ✅"`

---

## 🏗️ المرحلة 3: Architecture (Priority: LOW - Optional)

### A. إضافة Repository Pattern
- [ ] إنشاء abstract repositories في domain/
- [ ] إنشاء implementations في data/
- [ ] تحديث Controllers
- [ ] Git commit: `"arch: add repository pattern"`

### B. إضافة Use Cases
- [ ] إنشاء use cases للـ business logic
- [ ] فصل logic عن Controllers
- [ ] Git commit: `"arch: add use cases"`

### C. Error Handling
- [ ] إنشاء `core/error/failures.dart`
- [ ] إنشاء `core/error/exceptions.dart`
- [ ] توحيد معالجة الأخطاء
- [ ] Git commit: `"feat: unified error handling"`

---

## ✨ المرحلة 4: Quality (Priority: LOW - Optional)

### A. Form Validation
- [ ] إنشاء `core/utils/validators.dart`
- [ ] توحيد جميع Validations
- [ ] Git commit: `"feat: unified form validation"`

### B. Testing
- [ ] كتابة Unit Tests للـ Controllers
- [ ] كتابة Widget Tests
- [ ] Git commit: `"test: add tests"`

### C. Documentation
- [ ] تحديث README.md
- [ ] إضافة Comments للـ APIs
- [ ] Git commit: `"docs: update documentation"`

---

## 📊 Progress Tracker

### Overall Progress:
```
المرحلة 1: [          ] 0%
المرحلة 2: [          ] 0%
المرحلة 3: [          ] 0%
المرحلة 4: [          ] 0%
```

### Time Spent:
- المرحلة 1: _____ ساعات
- المرحلة 2: _____ ساعات
- المرحلة 3: _____ ساعات
- المرحلة 4: _____ ساعات
- **المجموع:** _____ ساعات

---

## 🎯 ملاحظات

### مشاكل واجهتها:
1. _________________________________
2. _________________________________
3. _________________________________

### حلول مطبقة:
1. _________________________________
2. _________________________________
3. _________________________________

### تحسينات إضافية:
1. _________________________________
2. _________________________________
3. _________________________________

---

## 🚀 Final Checklist

قبل إغلاق المشروع:
- [ ] جميع Tests تعمل
- [ ] `flutter analyze` نظيف
- [ ] جميع Features تعمل بشكل صحيح
- [ ] Code Review تم
- [ ] Documentation محدّث
- [ ] Git merge إلى main branch
- [ ] Deploy (إن وُجد)

---

## ✅ الحالة النهائية

**تاريخ البدء:** _______________  
**تاريخ الانتهاء:** _______________  
**الحالة:** ⬜ قيد التنفيذ | ⬜ مكتمل

**التوقيع:** _______________