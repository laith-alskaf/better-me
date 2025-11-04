# 🔧 مرجع الأوامر المفيدة - BetterMe Project

## 📋 Git Commands

### Setup
```bash
# إنشاء branch جديد للتطوير
git checkout -b refactoring/phase-1-cleanup

# عرض الـ branches
git branch

# التبديل بين branches
git checkout main
git checkout refactoring/phase-1-cleanup
```

### Commit & Push
```bash
# إضافة جميع التغييرات
git add .

# Commit مع رسالة
git commit -m "your message here"

# Push للـ remote
git push origin refactoring/phase-1-cleanup

# عرض الحالة
git status

# عرض التغييرات
git diff
```

### Undo Changes
```bash
# التراجع عن جميع التغييرات (قبل commit)
git checkout .

# التراجع عن ملف معين
git checkout -- path/to/file

# التراجع عن آخر commit (مع الاحتفاظ بالتغييرات)
git reset --soft HEAD~1

# التراجع عن آخر commit (حذف التغييرات)
git reset --hard HEAD~1
```

---

## 🔍 Flutter Search Commands (PowerShell)

### البحث عن Imports
```powershell
# البحث عن استيراد محدد
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "import.*package:provider"

# البحث عن CustomText
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "CustomText"

# البحث عن RxDart
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "import.*rxdart"

# البحث عن BLoC
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "new_entry_bloc"

# البحث عن Navigator (التقليدي)
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "Navigator\.push|Navigator\.pop"
```

### البحث عن Hard-coded Values
```powershell
# البحث عن EdgeInsets ثابتة
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "EdgeInsets\.all\([0-9]"

# البحث عن Colors ثابتة
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "Color\(0x"

# البحث عن BorderRadius ثابت
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "BorderRadius\.circular\([0-9]"
```

### البحث عن TODO/FIXME
```powershell
# البحث عن TODO
Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern "TODO|FIXME|HACK|XXX"
```

---

## 🧹 Flutter Cleanup Commands

### التنظيف الأساسي
```powershell
# تنظيف المشروع
flutter clean

# إعادة تحميل الـ dependencies
flutter pub get

# تنظيف شامل
flutter clean; Remove-Item -Recurse -Force .dart_tool; flutter pub get
```

### التحليل والفحص
```powershell
# تحليل الكود
flutter analyze

# تحليل مع الاقتراحات
flutter analyze --suggestions

# فحص الـ dependencies القديمة
flutter pub outdated

# عرض شجرة الـ dependencies
flutter pub deps
```

---

## 🏃 Flutter Run Commands

### تشغيل التطبيق
```powershell
# تشغيل عادي
flutter run

# تشغيل مع hot reload
flutter run --hot

# تشغيل في Release mode
flutter run --release

# تشغيل على جهاز محدد
flutter devices
flutter run -d <device-id>
```

### Build Commands
```powershell
# بناء APK
flutter build apk --release

# بناء App Bundle
flutter build appbundle --release

# بناء iOS
flutter build ios --release

# بناء Web
flutter build web --release
```

---

## 📊 File Operations (PowerShell)

### عرض الملفات
```powershell
# عرض محتوى مجلد
Get-ChildItem "d:\flutter\FLUTTER Projects\BetterMe_project\lib\core\widgets"

# عرض محتوى ملف
Get-Content "d:\flutter\FLUTTER Projects\BetterMe_project\lib\app\my_app_controller.dart"

# عد الملفات
(Get-ChildItem -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib" -Recurse -Filter "*.dart").Count

# عد الأسطر في جميع ملفات Dart
Get-ChildItem -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib" -Recurse -Filter "*.dart" | Get-Content | Measure-Object -Line
```

### حذف الملفات
```powershell
# حذف ملف
Remove-Item "d:\flutter\FLUTTER Projects\BetterMe_project\lib\app\my_app_controller.dart"

# حذف مجلد
Remove-Item -Recurse -Force "d:\flutter\FLUTTER Projects\BetterMe_project\lib\core\widgets"

# حذف مع التأكيد
Remove-Item -Confirm "path\to\file"
```

### نسخ ونقل
```powershell
# نسخ ملف
Copy-Item "source\file.dart" "destination\file.dart"

# نسخ مجلد
Copy-Item -Recurse "source\folder" "destination\folder"

# نقل ملف
Move-Item "source\file.dart" "destination\file.dart"
```

---

## 🔄 Find & Replace (VS Code)

### Find in Files
```
Ctrl + Shift + F
```

**Examples:**
- Pattern: `import 'package:BetterMe/core/widgets/custom_text.dart';`
- Replace: `import 'package:BetterMe/shared/widgets/index.dart';`

### Regex Examples
```regex
# Find EdgeInsets.all with numbers
EdgeInsets\.all\((\d+)\)

# Find Color hex values
Color\(0x[A-F0-9]{8}\)

# Find CustomText usage
CustomText\([\s\S]*?\)
```

---

## 📦 Package Management

### إضافة/حذف Packages
```powershell
# إضافة package
flutter pub add package_name

# إضافة dev dependency
flutter pub add --dev package_name

# حذف package (يدوياً من pubspec.yaml ثم):
flutter pub get

# ترقية package
flutter pub upgrade package_name

# ترقية جميع الـ packages
flutter pub upgrade
```

---

## 🧪 Testing Commands

### تشغيل الـ Tests
```powershell
# جميع الـ tests
flutter test

# test محدد
flutter test test/features/home/home_controller_test.dart

# مع coverage
flutter test --coverage

# عرض coverage report
genhtml coverage/lcov.info -o coverage/html
start coverage/html/index.html
```

---

## 🎯 Useful Scripts

### Script للبحث عن جميع Imports
```powershell
# حفظ في ملف: find_imports.ps1

$patterns = @(
    "import.*package:provider",
    "import.*rxdart",
    "import.*dartz",
    "CustomText",
    "CustomToast",
    "new_entry_bloc"
)

foreach ($pattern in $patterns) {
    Write-Host "Searching for: $pattern" -ForegroundColor Yellow
    Select-String -Path "d:\flutter\FLUTTER Projects\BetterMe_project\lib\**\*.dart" -Pattern $pattern
    Write-Host ""
}
```

**الاستخدام:**
```powershell
.\find_imports.ps1
```

---

### Script للتنظيف الشامل
```powershell
# حفظ في ملف: deep_clean.ps1

Write-Host "Starting deep clean..." -ForegroundColor Green

# Clean Flutter
flutter clean

# Remove build artifacts
Remove-Item -Recurse -Force "d:\flutter\FLUTTER Projects\BetterMe_project\build" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "d:\flutter\FLUTTER Projects\BetterMe_project\.dart_tool" -ErrorAction SilentlyContinue

# Pub get
flutter pub get

Write-Host "Deep clean complete!" -ForegroundColor Green
```

**الاستخدام:**
```powershell
.\deep_clean.ps1
```

---

### Script لحساب الإحصائيات
```powershell
# حفظ في ملف: stats.ps1

$libPath = "d:\flutter\FLUTTER Projects\BetterMe_project\lib"

Write-Host "Project Statistics:" -ForegroundColor Cyan

# عدد ملفات Dart
$dartFiles = (Get-ChildItem -Path $libPath -Recurse -Filter "*.dart").Count
Write-Host "Dart files: $dartFiles" -ForegroundColor Yellow

# عدد الأسطر
$lines = (Get-ChildItem -Path $libPath -Recurse -Filter "*.dart" | Get-Content | Measure-Object -Line).Lines
Write-Host "Total lines: $lines" -ForegroundColor Yellow

# عدد الـ Controllers
$controllers = (Get-ChildItem -Path $libPath -Recurse -Filter "*_controller.dart").Count
Write-Host "Controllers: $controllers" -ForegroundColor Yellow

# عدد الـ Views/Pages
$views = (Get-ChildItem -Path $libPath -Recurse -Filter "*_view.dart").Count
Write-Host "Views: $views" -ForegroundColor Yellow

# حجم المشروع
$size = (Get-ChildItem -Path $libPath -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
Write-Host "Project size: $([math]::Round($size, 2)) MB" -ForegroundColor Yellow
```

**الاستخدام:**
```powershell
.\stats.ps1
```

---

## 🚨 Quick Fixes

### إصلاح مشاكل شائعة

#### المشكلة: "Unable to find package"
```powershell
flutter clean
flutter pub get
```

#### المشكلة: "Version solving failed"
```powershell
# احذف pubspec.lock
Remove-Item pubspec.lock
flutter pub get
```

#### المشكلة: "Gradle build failed"
```powershell
Set-Location android
.\gradlew clean
Set-Location ..
flutter clean
flutter pub get
```

#### المشكلة: "Pod install failed" (iOS)
```powershell
Set-Location ios
pod deintegrate
pod install
Set-Location ..
```

---

## 📝 VS Code Shortcuts

### Essential Shortcuts
```
Ctrl + P          # Quick file open
Ctrl + Shift + P  # Command palette
Ctrl + Shift + F  # Find in files
Ctrl + K, Ctrl + F # Format selection
Alt + Shift + F   # Format document
F12              # Go to definition
Ctrl + .         # Quick fix
Ctrl + Shift + R # Refactor
```

### Flutter Specific
```
Ctrl + Shift + P > "Flutter: Hot Reload"
Ctrl + Shift + P > "Flutter: Hot Restart"
Ctrl + Shift + P > "Dart: Fix All"
```

---

## 🎨 Code Generation

### Generate Code
```powershell
# بناء الكود المولّد
flutter pub run build_runner build

# مسح وإعادة البناء
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (تلقائي)
flutter pub run build_runner watch
```

---

## 📊 Performance Analysis

### Profile Commands
```powershell
# Profile mode
flutter run --profile

# عرض Performance overlay
flutter run --profile --trace-skia

# Build timeline
flutter run --profile --trace-startup
```

---

## 💡 Tips & Tricks

### سرعة التطوير
```powershell
# Hot Reload سريع
# في terminal أثناء flutter run:
r  # Hot reload
R  # Hot restart
q  # Quit
```

### تحليل الأداء
```powershell
# حجم التطبيق
flutter build apk --analyze-size

# Dependency graph
flutter pub deps --style=tree
```

---

## 🔗 Useful Links

- Flutter Docs: https://flutter.dev/docs
- GetX: https://github.com/jonataslaw/getx
- Pub.dev: https://pub.dev
- Flutter DevTools: `flutter pub global activate devtools`

---

**آخر تحديث:** 2025-01-XX  
**الحالة:** ✅ جاهز للاستخدام