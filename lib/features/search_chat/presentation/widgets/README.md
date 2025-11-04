# Search Widgets - أدلة الاستخدام السريعة

> دليل شامل وسريع لاستخدام الـ widgets المخصصة للبحث

---

## 📦 الـ Widgets المتاحة

### 1️⃣ SearchInputWidget
مربع إدخال البحث الموحد والذكي

```dart
SearchInputWidget(
  controller: myController,
  hintTextKey: 'search_placeholder_faq',  // مفتاح النص المترجم
  onSearchPressed: () {
    // يتم استدعاؤه عند الضغط على زر البحث
    performSearch();
  },
  onClearPressed: () {
    // يتم استدعاؤه عند الضغط على زر المسح
    // إذا كان null، سيتم مسح الـ controller تلقائياً
  },
  isLoading: isLoading,  // إذا كان true، يعرض أيقونة تحميل
  onChanged: (value) {
    // يتم استدعاؤه عند كل تغيير في النص
  },
)
```

**المميزات:**
- ✅ أيقونة بحث موحدة
- ✅ أيقونة مسح ذكية (تظهر فقط إذا كان هناك نص)
- ✅ مؤشر تحميل أثناء البحث
- ✅ دعم RTL/LTR

---

### 2️⃣ SearchResultCard
بطاقة لعرض نتيجة بحث واحدة قابلة للتوسيع

```dart
SearchResultCard(
  question: 'ما فوائد الماء؟',
  answer: 'الماء ضروري للصحة...',
  onTap: () {
    // يتم استدعاؤه عند الضغط على البطاقة
  },
  isExpanded: false,  // هل البطاقة موسعة؟
  onExpandChanged: (isExpanded) {
    // يتم استدعاؤه عند تغيير حالة التوسيع
  },
)
```

**الميزات:**
- ✅ توسيع/انطواء سلس
- ✅ أيقونات جذابة
- ✅ أزرار تقييم (إعجاب/عدم إعجاب)

---

### 3️⃣ SearchEmptyState
حالة فارغة عند عدم وجود نتائج

```dart
SearchEmptyState(
  messageKey: 'search_no_results',  // مفتاح الرسالة
  customMessage: null,  // أو استخدم رسالة مخصصة
  onRetry: () {
    // يتم استدعاؤه عند الضغط على زر إعادة المحاولة
  },
  showRetryButton: true,  // هل نعرض زر إعادة المحاولة؟
)
```

**الميزات:**
- ✅ أيقونة كبيرة وجذابة
- ✅ رسائل ودية
- ✅ زر إعادة محاولة اختياري

---

### 4️⃣ SearchLoadingState
حالة التحميل أثناء البحث

```dart
SearchLoadingState(
  messageKey: 'thank_you_for_asking',  // مفتاح الرسالة
  customMessage: null,  // أو رسالة مخصصة
)
```

**الميزات:**
- ✅ أنيميشن دوران جذاب
- ✅ نقاط متحركة
- ✅ رسائل تحفيزية

---

### 5️⃣ FAQItemWidget
بطاقة سؤال وجواب قابلة للتوسيع

```dart
FAQItemWidget(
  question: 'كم كوب ماء يجب أن أشرب يومياً؟',
  answer: 'يفضل شرب 8 أكواب ماء يومياً...',
  index: 0,  // رقم السؤال (للترقيم)
)
```

**الميزات:**
- ✅ أنيميشن احترافي
- ✅ ترقيم تلقائي ملون
- ✅ انتقالات سلسة

---

## 🎯 حالات الاستخدام العملية

### الحالة 1: صفحة الأسئلة الشائعة

```dart
class SearchScreen extends GetView<SearchChatgptController> {
  @override
  Widget build(BuildContext context) {
    final chatGptService = Get.find<ChatGptService>();
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppScaffoldAppBar(titleKey: 'common_faqs'),
      body: Obx(
        () => Column(
          children: [
            // مربع البحث
            SearchInputWidget(
              controller: searchController,
              hintTextKey: 'search_placeholder_faq',
              onSearchPressed: () {},
              isLoading: false,
            ),
            
            // قائمة الأسئلة
            Expanded(
              child: ListView.builder(
                itemCount: chatGptService.chatListQuestions.length,
                itemBuilder: (context, index) {
                  return FAQItemWidget(
                    question: chatGptService.chatListQuestions[index],
                    answer: chatGptService.chatListAnswer[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### الحالة 2: صفحة البحث مع ChatGPT

```dart
class SearchChatGPTView extends GetView<SearchChatgptController> {
  @override
  Widget build(BuildContext context) {
    final chatGptService = Get.find<ChatGptService>();
    final controller = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          // مربع البحث
          SearchInputWidget(
            controller: controller,
            hintTextKey: 'what_do_you_want_to_know',
            onSearchPressed: () {
              chatGptService.getAnswer(messages: controller.text);
            },
            isLoading: chatGptService.isBusy.value,
          ),
          
          // المحتوى
          Expanded(
            child: Obx(
              () {
                if (chatGptService.isBusy.value) {
                  return SearchLoadingState();
                }
                
                if (chatGptService.chatListQuestions.isEmpty) {
                  return SearchEmptyState(
                    onRetry: () {
                      // إعادة البحث
                    },
                  );
                }
                
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SearchResultCard(
                        question: chatGptService.chatListQuestions[0],
                        answer: chatGptService.chatListAnswer[0],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 🎨 التخصيص

### تغيير الألوان
جميع الـ widgets تستخدم `AppColors`:

```dart
// تعديل الألوان من AppColors
// lib/config/theme/app_colors.dart
static const Color primary = Color(0xFF7CBD43);
static const Color success = Color(0xFF388E3C);
```

### تغيير الأبعاد
استخدم `DesignSystem`:

```dart
// في الـ widget
padding: EdgeInsets.all(DesignSystem.base),
borderRadius: DesignSystem.radiusBase,
```

### تغيير الترجمات
أضف مفاتيح جديدة في `AppLocalizations`:

```dart
// في app_localizations.dart
'my_key': 'My Arabic Text',  // العربية
// و
'my_key': 'My English Text',  // الإنجليزية
```

---

## 📐 Responsive Design

جميع الـ widgets responsive افتراضياً:

```dart
// الأبعاد تتكيف مع الشاشة
fontSize: 14.sp      // نسبة من حجم الشاشة
height: 6.h          // 6% من ارتفاع الشاشة
width: 80.w          // 80% من عرض الشاشة
```

---

## 🌐 اللغات

جميع النصوص تدعم العربية والإنجليزية:

```dart
// استخدام مفاتيح الترجمة
hintTextKey: 'search_placeholder_faq',
// سيتم ترجمتها تلقائياً حسب اللغة الحالية
```

---

## 🔧 الدالات المساعدة في Controller

```dart
SearchChatgptController controller = Get.find();

// تعيين حالة البحث
controller.setSearching(true);

// تحديث نص البحث
controller.updateSearchQuery('الماء');

// حذف البحث
controller.clearSearch();
```

---

## ✅ قائمة التحقق

عند إضافة widget جديد يستخدم الـ widgets أعلاه:

- [ ] تم استيراد `widgets/index.dart`
- [ ] تم استخدام `AppColors` للألوان
- [ ] تم استخدام `DesignSystem` للأبعاد
- [ ] تم استخدام مفاتيح الترجمة (`.tr`)
- [ ] تم استخدام `Obx` مع GetX
- [ ] تم اختبار في العربية والإنجليزية
- [ ] تم اختبار على شاشات مختلفة
- [ ] لا توجد أخطاء في Flutter Analyze

---

## 🚀 نصائح الأداء

1. **استخدم `Obx` للتغييرات الديناميكية فقط**
   ```dart
   Obx(() => SearchInputWidget(...))  // لا تضع كل شيء هنا
   ```

2. **أعد استخدام Controllers**
   ```dart
   final controller = Get.find<SearchChatgptController>();
   ```

3. **تجنب إعادة البناء غير الضرورية**
   ```dart
   const SearchEmptyState()  // استخدم const عندما يكون ممكناً
   ```

---

## 📞 مثال كامل

```dart
import 'package:BetterMe/features/search_chat/presentation/widgets/index.dart';

class MySearchPage extends StatefulWidget {
  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  late TextEditingController searchController;
  final controller = Get.find<SearchChatgptController>();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppScaffoldAppBar(titleKey: 'search'),
      body: Column(
        children: [
          SearchInputWidget(
            controller: searchController,
            hintTextKey: 'search_placeholder_faq',
            onSearchPressed: _handleSearch,
            isLoading: controller.isSearching.value,
          ),
          Expanded(
            child: Obx(
              () => controller.isSearching.value
                  ? SearchLoadingState()
                  : controller.searchResults.isEmpty
                      ? SearchEmptyState()
                      : ListView.builder(
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            return SearchResultCard(
                              question: controller.searchResults[index],
                              answer: 'Answer...',
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSearch() {
    controller.setSearching(true);
    // منطق البحث
    controller.setSearching(false);
  }
}
```

---

**آخر تحديث**: 2025-11-04
**الإصدار**: 1.0