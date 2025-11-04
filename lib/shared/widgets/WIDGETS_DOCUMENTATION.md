# 📱 Shared Widgets Documentation

تم تحسين وإعادة تنظيم مجلد lib/shared/widgets ليكون احترافياً وموحداً باستخدام **DesignSystem** و**Responsive Design**.

## 📂 هيكل المشروع الجديد

\\\
lib/shared/widgets/
├── common/                          # مكونات عامة
│   ├── app_text.dart               # مكون النصوص الموحد
│   ├── app_divider.dart            # فاصل موحد
│   └── app_progress_indicator.dart # مؤشر التقدم
├── buttons/                        # مكونات الأزرار
│   └── app_button.dart             # زر موحد (4 أنماط)
├── inputs/                         # مكونات الإدخال
│   └── app_text_form_field.dart    # حقل إدخال موحد
├── cards/                          # مكونات البطاقات
│   ├── app_card.dart               # بطاقة موحدة
│   └── app_expansion_card.dart     # بطاقة قابلة للتوسع (FAQ)
├── navigation/                     # مكونات الملاحة
│   └── app_navigation_bar.dart     # شريط ملاحة موحد
├── dialogs/                        # نوافذ وإشعارات
│   ├── app_snack_bar.dart          # إشعارات موحدة
│   ├── app_loading_dialog.dart     # نافذة تحميل
│   └── app_alert_dialog.dart       # نافذة تنبيه/تأكيد
├── index.dart                      # تصدير شامل
└── legacy/                         # (اختياري) ملفات قديمة
\\\

## 🎨 المكونات الرئيسية

### 1️⃣ AppText - مكون النصوص الموحد
**الملف**: \common/app_text.dart\

**الميزات**:
- أنماط مدمجة (heading1-3, body, caption)
- دعم RTL/LTR تلقائي
- تخصيص كامل للألوان والأحجام

**الاستخدام**:
\\\dart
// استخدام النمط المدمج
AppText(
  'عنوان رئيسي',
  style: AppText.heading1,
)

// استخدام مخصص
AppText(
  'نص عادي',
  color: AppColors.primary,
  fontSize: 16,
  fontWeight: FontWeight.w600,
)
\\\

---

### 2️⃣ AppButton - زر موحد (4 أنماط)
**الملف**: \uttons/app_button.dart\

**الأنماط**:
- \ButtonStyle.solid\ - زر ممتلئ
- \ButtonStyle.outline\ - زر بحد
- \ButtonStyle.text\ - زر نصي
- \ButtonStyle.gradient\ - زر بتدرج

**الاستخدام**:
\\\dart
// زر ممتلئ
AppButton(
  label: 'حفظ',
  onPressed: () {},
  style: ButtonStyle.solid,
)

// زر بحد
AppButton(
  label: 'إلغاء',
  onPressed: () {},
  style: ButtonStyle.outline,
)

// زر بأيقونة
AppButton(
  label: 'إرسال',
  onPressed: () {},
  icon: Icons.send,
  isLoading: isLoading,
)

// زر معطّل
AppButton(
  label: 'مختاره',
  onPressed: () {},
  isEnabled: false,
)
\\\

---

### 3️⃣ AppTextFormField - حقل إدخال موحد
**الملف**: \inputs/app_text_form_field.dart\

**الميزات**:
- دعم RTL/LTR تلقائي
- أيقونات بادئة/لاحقة
- معالجة كلمات المرور تلقائياً
- تحقق شامل
- Responsive padding

**الاستخدام**:
\\\dart
AppTextFormField(
  hintText: 'البريد الإلكتروني',
  keyboardType: TextInputType.emailAddress,
  controller: emailController,
  validator: (value) {
    if (value?.isEmpty ?? true) return 'البريد مطلوب';
    return null;
  },
  prefixIcon: Icon(Icons.email),
)

// حقل كلمة مرور
AppTextFormField(
  hintText: 'كلمة المرور',
  obscureText: true,
  controller: passwordController,
)

// حقل متعدد الأسطر
AppTextFormField(
  hintText: 'الملاحظات',
  maxLines: 5,
  minLines: 3,
)
\\\

---

### 4️⃣ AppCard - بطاقة موحدة
**الملف**: \cards/app_card.dart\

**الاستخدام**:
\\\dart
AppCard(
  padding: EdgeInsets.all(DesignSystem.base),
  child: Column(
    children: [
      AppText('معلومات المستخدم', style: AppText.heading3),
      AppDivider(),
      AppText('البريد: user@example.com'),
    ],
  ),
  onTap: () {},
)
\\\

---

### 5️⃣ AppExpansionCard - بطاقة قابلة للتوسع
**الملف**: \cards/app_expansion_card.dart\

**مناسب للـ FAQ والمحتوى المتوسع**

**الاستخدام**:
\\\dart
AppExpansionCard(
  title: 'كيف أستخدم التطبيق؟',
  content: 'يمكنك البدء بـ...',
  initiallyExpanded: false,
  onExpanded: () => print('توسع'),
  onCollapsed: () => print('انطوى'),
)
\\\

---

### 6️⃣ AppSnackBar - إشعارات موحدة
**الملف**: \dialogs/app_snack_bar.dart\

**الأنواع**:
- \SnackBarType.success\ - نجاح (أخضر)
- \SnackBarType.error\ - خطأ (أحمر)
- \SnackBarType.warning\ - تحذير (برتقالي)
- \SnackBarType.info\ - معلومة (أزرق)

**الاستخدام**:
\\\dart
// رسالة نجاح
AppSnackBar.show(
  context,
  message: 'تم الحفظ بنجاح',
  type: SnackBarType.success,
)

// رسالة خطأ
AppSnackBar.show(
  context,
  message: 'حدث خطأ ما',
  type: SnackBarType.error,
)
\\\

---

### 7️⃣ AppLoadingDialog - نافذة تحميل
**الملف**: \dialogs/app_loading_dialog.dart\

**الاستخدام**:
\\\dart
// عرض نافذة التحميل
AppLoadingDialog.show(
  context,
  message: 'جاري التحميل...',
  barrierDismissible: false,
)

// إغلاق نافذة التحميل
AppLoadingDialog.dismiss(context)
\\\

---

### 8️⃣ AppAlertDialog - نافذة تنبيه/تأكيد
**الملف**: \dialogs/app_alert_dialog.dart\

**الاستخدام**:
\\\dart
AppAlertDialog.show(
  context,
  title: 'تأكيد الحذف',
  message: 'هل أنت متأكد من حذف هذا العنصر؟',
  confirmButtonText: 'حذف',
  cancelButtonText: 'إلغاء',
  onConfirm: () {
    // تنفيذ الحذف
  },
  onCancel: () {
    // إلغاء
  },
)
\\\

---

### 9️⃣ AppNavigationBar - شريط ملاحة موحد
**الملف**: \
avigation/app_navigation_bar.dart\

**الاستخدام**:
\\\dart
AppNavigationBar(
  items: [
    NavItem(label: 'الرئيسية', icon: Icons.home),
    NavItem(label: 'الحاسبات', icon: Icons.calculate),
    NavItem(label: 'الأدوية', icon: Icons.medication, badgeCount: 3),
  ],
  selectedIndex: selectedIndex,
  onItemTapped: (index) {
    setState(() => selectedIndex = index);
  },
)
\\\

---

## 🎯 الاستيراد الموحد

**استيراد جميع المكونات**:
\\\dart
import 'package:BetterMe/shared/widgets/index.dart';
\\\

**أو استيراد مكونات محددة**:
\\\dart
import 'package:BetterMe/shared/widgets/common/app_text.dart';
import 'package:BetterMe/shared/widgets/buttons/app_button.dart';
import 'package:BetterMe/shared/widgets/inputs/app_text_form_field.dart';
\\\

---

## 🌈 استخدام DesignSystem

جميع المكونات تستخدم **DesignSystem** للثوابت الموحدة:

\\\dart
// مسافات
DesignSystem.xs = 4.0
DesignSystem.sm = 8.0
DesignSystem.md = 12.0
DesignSystem.base = 16.0
DesignSystem.lg = 20.0
DesignSystem.xl = 24.0

// حجم الأيقونات
DesignSystem.iconMd = 24.0
DesignSystem.iconLg = 32.0

// ارتفاع الأزرار
DesignSystem.buttonHeightBase = 44.0
DesignSystem.buttonHeightLarge = 52.0

// الزوايا
DesignSystem.radiusBase = 16.0
DesignSystem.radiusMd = 12.0

// الظلال
DesignSystem.shadowElevation4
DesignSystem.shadowElevation8
DesignSystem.shadowElevation12

// الحركات
DesignSystem.animationDurationNormal = 300ms
DesignSystem.animationDurationSlow = 500ms
\\\

---

## 📱 Responsive Design

جميع المكونات متجاوبة تلقائياً مع جميع أحجام الشاشات:

\\\dart
AppButton(
  label: 'موافق',
  onPressed: () {},
  width: MediaQuery.of(context).size.width * 0.8,
)
\\\

---

## 🎨 التخصيص المتقدم

**تخصيص الألوان**:
\\\dart
AppButton(
  label: 'حفظ',
  onPressed: () {},
  backgroundColor: Colors.green,
  foregroundColor: Colors.white,
)

AppCard(
  backgroundColor: AppColors.background,
  borderColor: AppColors.primary,
  borderRadius: 20,
)
\\\

---

## ✅ أفضل الممارسات

1. **استخدم AppText دائماً** بدلاً من Text العادي
2. **استخدم DesignSystem** للمسافات والأحجام
3. **استخدم AppButton** لجميع الأزرار
4. **استخدم AppTextFormField** لكل حقول الإدخال
5. **استخدم AppSnackBar** للإشعارات
6. **احترم RTL/LTR** - المكونات تدعمها تلقائياً

---

## 📝 ملاحظات

- جميع المكونات دعم كامل لـ RTL/LTR تلقائياً
- جميع المكونات responsive وتتكيف مع الشاشات المختلفة
- جميع المكونات تستخدم DesignSystem
- جميع المكونات آمنة للاستخدام والتخصيص

---

**آخر تحديث**: 2025-11-03
**الحالة**: ✅ جاهز للإنتاج
