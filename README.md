<div align="center">

# 🏥 BetterMe — Health & Wellness Application

**A comprehensive Flutter application for health monitoring, medical calculations, and AI-powered health assistance**

[![Flutter](https://img.shields.io/badge/Flutter-3.3.1+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.3.1+-00B4AB?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![GetX](https://img.shields.io/badge/GetX-State_Management-8B5CF6?style=for-the-badge)](https://pub.dev/packages/get)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-black?style=for-the-badge&logo=android&logoColor=white)](https://flutter.dev/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Download APK](https://img.shields.io/badge/Download%20APK-Google%20Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)](https://drive.google.com/drive/folders/1PTTms0S6cwumAz42Ib0R8BlxhqOSv6e1)

[Features](#-key-features) • [Tech Stack](#️-tech-stack--architecture) • [Getting Started](#-quick-start) • [Download](#-download) • [Contributing](#-contributing)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Tech Stack & Architecture](#️-tech-stack--architecture)
- [Project Structure](#-project-structure)
- [Quick Start](#-quick-start)
- [Documentation](#-documentation)
- [Testing](#-testing)
- [Troubleshooting](#-troubleshooting)
- [Performance](#-performance)
- [Security](#-security)
- [Download](#-download)
- [Roadmap](#-roadmap)
- [Contributing](#-contributing)
- [License](#-license)

---

## 📖 Overview

**BetterMe** is a feature-rich Flutter health and wellness application designed to empower users with health insights, personalized medical calculations, medication management, and AI-powered health assistance. Built with **Clean Architecture** and **GetX state management**, the app delivers a seamless, responsive experience across Android and iOS.

### What Does BetterMe Do?

| Capability | Description |
|---|---|
| 📊 **7 Health Calculators** | BMI, Calories, Ideal Weight, Blood Pressure, Water Intake, Fat Consumption, Smoking Cost |
| 💊 **Medicine Management** | Track medications with smart time-based reminders and calendar view |
| 💬 **AI Chat Assistant** | Real-time health Q&A powered by ChatGPT integration |
| 🌍 **Bilingual Support** | Full Arabic (RTL) / English (LTR) localization with dynamic switching |
| 🎨 **Modern UI/UX** | Responsive design with a unified design system and smooth animations |
| 📱 **Cross-Platform** | Native Android and iOS support |

---

## ✨ Key Features

### 🧮 Health Calculators (7 Tools)

| Calculator | Purpose | Key Inputs |
|---|---|---|
| **BMI Calculator** | Body Mass Index | Age, Height, Weight, Gender |
| **Calories Calculator** | Daily caloric intake | Activity level, Age, Weight |
| **Perfect Weight** | Ideal body weight | Height, Frame size |
| **Blood Pressure** | BP classification | Systolic, Diastolic readings |
| **Water Need** | Daily hydration target | Weight, Activity level |
| **Fat Eating** | Daily fat budget | Age, Weight, Activity |
| **Smoking Cost** | Financial impact of smoking | Cigarettes/day, Price per pack |

### 💊 Medicine Management

- **Full CRUD**: Add, edit, and delete medicines with all details
- **Smart Reminders**: Time-based and date-based local notifications
- **Medicine Types**: Pills, Tablets, Capsules, Liquids, Injections, Sprays, Creams
- **Calendar Integration**: Visual medicine schedule using `table_calendar`
- **Timezone Support**: Accurate reminder timing across timezones via `timezone`

### 🤖 AI Health Assistant

- **ChatGPT Integration**: Ask personalized health questions
- **Real-time Responses**: Streaming chat interface
- **Offline Detection**: Graceful connectivity monitoring with user feedback
- **History Management**: Persistent Q&A history per session

### 🌐 Localization & Theme

- **Arabic** (AR_SA) — Full RTL layout support
- **English** (EN_US) — Standard LTR layout
- **Dynamic Switching**: Change language without app restart
- **150+ Translation Keys**: Comprehensive text coverage
- **Responsive Design**: Adapts to phones and tablets using `sizer`

---

## ⚙️ Tech Stack & Architecture

### Core

| Technology | Purpose |
|---|---|
| **Flutter 3.3.1+ / Dart 3.3.1+** | Cross-platform mobile framework |
| **GetX v4.6.5** | State management, routing, and dependency injection |
| **Dartz** | Functional programming with `Either` for explicit error handling |
| **Clean Architecture** | Separation of Presentation, Domain, and Data layers |

### Architecture Overview

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│     (Views, Controllers, Widgets)       │
├─────────────────────────────────────────┤
│             Domain Layer                │
│       (Business Logic, Entities)        │
├─────────────────────────────────────────┤
│              Data Layer                 │
│   (Services, Repositories, Models)      │
└─────────────────────────────────────────┘
```

**Data Flow:**
```
UI (Views) → GetX Controllers → Repository Layer → Services / SharedPreferences / API
```

### Key Packages

#### UI & Design

| Package | Version | Purpose |
|---|---|---|
| `sizer` | 2.0.15 | Responsive layout scaling |
| `lottie` | 2.6.0 | Lottie animations |
| `flutter_svg` | 1.0.0 | SVG asset rendering |
| `google_nav_bar` | 5.0.6 | Custom bottom navigation bar |
| `animated_notch_bottom_bar` | 1.0.0 | Notched navigation bar |
| `flutter_spinkit` | 5.2.0 | Loading indicators |
| `awesome_dialog` | 3.0.2 | Dialog components |
| `bot_toast` | 4.0.2 | Non-intrusive toast messages |

#### Data & Storage

| Package | Version | Purpose |
|---|---|---|
| `shared_preferences` | 2.2.2 | Key-value local storage |
| `json_annotation` | 4.8.1 | JSON serialization annotations |

#### Networking

| Package | Purpose |
|---|---|
| `dio` | HTTP client with interceptors |
| `retrofit` | REST API code generation |
| `connectivity_plus` | Real-time network status monitoring |

#### Notifications & Utilities

| Package | Version | Purpose |
|---|---|---|
| `flutter_local_notifications` | 19.5.0 | Local push notifications |
| `table_calendar` | 3.0.9 | Calendar widget for medicine schedule |
| `timezone` | 0.10.0 | Accurate timezone management |
| `intl` | 0.20.2 | Localization and date formatting |

---

## 📁 Project Structure

```
lib/
├── main.dart                           # Application entry point
│
├── app/
│   ├── bindings/
│   │   └── app_bindings.dart           # Global service initialization
│   ├── my_app.dart                     # App configuration & theming
│   └── my_app_controller.dart
│
├── config/
│   ├── localization/
│   │   ├── localization_controller.dart
│   │   ├── app_localizations.dart      # 150+ translation keys (AR/EN)
│   │   └── index.dart
│   ├── routes/
│   │   ├── app_pages.dart              # Route definitions
│   │   └── app_routes.dart             # Route name constants
│   └── theme/
│       ├── app_colors.dart             # Color palette
│       ├── app_text_styles.dart        # Typography
│       ├── app_theme.dart              # Material theme config
│       └── design_system.dart          # Spacing, sizing constants
│
├── core/
│   ├── constants/                      # App-wide constants
│   ├── data/models/                    # Shared data models
│   ├── enums/                          # Enumerations
│   ├── extensions/                     # Dart extensions
│   ├── error/                          # Error types and handling
│   ├── services/
│   │   ├── connectivity_service.dart
│   │   ├── storage_service.dart
│   │   └── logger_service.dart
│   └── utils/                          # Utility functions
│
├── features/                           # Feature modules
│   ├── splash/
│   ├── home/
│   ├── calculator/                     # 7 health calculators
│   ├── search_chat/                    # AI chat assistant
│   ├── medicine_reminder/              # Medicine CRUD + notifications
│   ├── bindings/
│   │   ├── home_binding.dart
│   │   ├── calculator_binding.dart
│   │   ├── search_binding.dart
│   │   └── medicine_binding.dart
│   └── main_view.dart                  # Bottom-tab navigation hub
│
└── shared/
    ├── services/
    │   └── local_notification_service.dart
    ├── utils/
    │   └── utils.dart
    └── widgets/
        ├── unified_widgets.dart        # Consolidated reusable components
        ├── custom_navigation_bar.dart
        ├── custom_toast.dart
        └── index.dart
```

---

## 🚀 Quick Start

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.3.1 or higher**
- [Dart SDK](https://dart.dev/get-dart) **3.3.1 or higher**
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extension
- A configured Android Emulator or physical device

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/laith-alskaf/betterme_project.git
cd betterme_project
```

**2. Install dependencies**
```bash
flutter clean
flutter pub get
```

**3. Generate serialization code** *(if needed)*
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**4. Run the application**
```bash
# Debug mode
flutter run

# Specific device
flutter run -d <device_id>

# List available devices
flutter devices
```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store recommended)
flutter build appbundle --release

# iOS (requires macOS + Xcode)
flutter build ios --release
```

### Platform-Specific Configuration

#### Android
- **Min SDK**: 24 (Android 7.0)
- **Package Name**: `com.example.betterme`
- Configure a signing keystore for production builds

#### iOS
- **Deployment Target**: iOS 11.0+
- **Swift Version**: 5.0+
- Run `pod install` inside the `ios/` directory after `flutter pub get`

---

## 📚 Documentation

### State Management with GetX

```dart
// Define a controller
class HomeController extends GetxController {
  var count = 0.obs; // Reactive variable

  void increment() {
    count++; // Automatically triggers UI rebuild
  }
}

// Use in a widget
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() => Text('Count: ${controller.count}'));
  }
}
```

### Navigation

```dart
// Navigate to a named route
Get.toNamed(AppRoutes.calculator);

// Pass arguments
Get.toNamed(AppRoutes.medicineDetails, arguments: medicineId);

// Go back
Get.back();

// Replace current route
Get.off(AppRoutes.home);
```

### Localization

```dart
// Use a translation key
Text('welcome'.tr) // Returns localized text

// Switch language at runtime
LocalizationController.instance.changeLanguage(Locale('ar', 'SA'));

// Check current language
bool isArabic = LocalizationController.instance.isArabic;
```

### Design System

```dart
// Use predefined spacing
Padding(
  padding: DesignSystem.paddingBase,
  child: child,
)

// Use standard button height
SizedBox(
  height: DesignSystem.buttonHeightMedium,
  child: AppButton(...),
)

// Use standard border radius
Container(
  decoration: BoxDecoration(
    borderRadius: DesignSystem.borderRadiusMedium,
  ),
)
```

### File Naming Conventions

| Type | Convention | Example |
|---|---|---|
| Dart Files | `snake_case` | `home_controller.dart` |
| Classes | `PascalCase` | `HomeController` |
| Constants | `camelCase` | `const maxRetries = 3` |
| Variables | `camelCase` | `var userName = ''` |
| Views | Suffix with `View` | `HomeView` |
| Controllers | Suffix with `Controller` | `HomeController` |
| Bindings | Suffix with `Binding` | `HomeBinding` |

### Adding a New Feature

```bash
# 1. Create feature directory structure
mkdir -p lib/features/new_feature/{controller,view,model}
```

```dart
// 2. Create the controller
class NewFeatureController extends GetxController {}

// 3. Create the view
class NewFeatureView extends StatelessWidget {}

// 4. Create the binding
class NewFeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewFeatureController());
  }
}
```

```dart
// 5. Register the route in lib/config/routes/app_pages.dart
GetPage(
  name: AppRoutes.newFeature,
  page: () => const NewFeatureView(),
  binding: NewFeatureBinding(),
)
```

---

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Test Structure

```
test/
├── models/          # Unit tests for data models
└── widget_test.dart # Widget tests
```

### Example Test

```dart
void main() {
  group('Medicine Model Tests', () {
    test('should create instance correctly', () {
      final medicine = Medicine(
        id: '1',
        name: 'Aspirin',
        dosage: '500mg',
      );

      expect(medicine.id, '1');
      expect(medicine.name, 'Aspirin');
    });
  });
}
```

---

## 🛠️ Development

### Code Quality

```bash
# Run Dart analyzer
flutter analyze

# Format code
dart format lib/

# Check for issues
flutter pub outdated
```

### Build Configuration Files

| File | Purpose |
|---|---|
| `pubspec.yaml` | Dependencies and project metadata |
| `analysis_options.yaml` | Lint rules and code style |
| `android/app/build.gradle.kts` | Android build configuration |
| `ios/Podfile` | iOS native dependencies |

### Color Palette

Colors are defined in `lib/config/theme/app_colors.dart`:

```dart
class AppColors {
  static const Color primary      = Color(0xFF6200EE);
  static const Color primaryLight = Color(0xFF9C27B0);
  static const Color secondary    = Color(0xFF03DAC6);
  static const Color white        = Color(0xFFFFFFFF);
  static const Color black        = Color(0xFF000000);
  static const Color grey         = Color(0xFF757575);
}
```

To customize the theme:
1. **Colors** → edit `lib/config/theme/app_colors.dart`
2. **Typography** → edit `lib/config/theme/app_text_styles.dart`
3. **Spacing/Sizing** → edit `lib/config/theme/design_system.dart`
4. Rebuild: `flutter clean && flutter pub get && flutter run`

---

## 🚨 Troubleshooting

### Build Fails

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

### Hot Reload Not Working

```bash
flutter run --no-fast-start
```

### Android Build Issues

```bash
flutter pub get
cd android && ./gradlew clean
cd ..
flutter clean && flutter run
```

### iOS Build Issues

```bash
cd ios
pod update
cd ..
flutter run
```

---

## 📊 Performance Targets

| Metric | Target | Notes |
|---|---|---|
| **App Startup Time** | < 500ms | Optimized with permanent GetX bindings |
| **Memory Usage** | < 100MB | Efficient reactive state management |
| **Frame Rate** | 60 FPS | Smooth animations via Lottie + transitions |
| **Build Time** | < 2 min | Dev build (machine-dependent) |

---

## 🔒 Security

| Practice | Details |
|---|---|
| **HTTPS Only** | All API calls use secure HTTPS connections |
| **Input Validation** | All user inputs are validated before processing |
| **Local Storage** | Sensitive data stored with `shared_preferences` + obfuscation |
| **Minimal Permissions** | Only necessary platform permissions are requested |
| **Code Obfuscation** | `--obfuscate --split-debug-info` enabled for release builds |

---

## 📥 Download

The latest release of **BetterMe** is available for direct download from Google Drive:

<div align="center">

[![Download APK](https://img.shields.io/badge/Download%20APK-Google%20Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)](https://drive.google.com/drive/folders/1PTTms0S6cwumAz42Ib0R8BlxhqOSv6e1)

</div>

> **Note:** This APK targets Android devices (Min SDK 24 / Android 7.0+). For iOS, see the [Quick Start](#-quick-start) section for local build instructions using Xcode.

---

## 🗺️ Roadmap

- [ ] Offline mode for all calculators
- [ ] Cloud sync for medicine reminders
- [ ] Dark mode support
- [ ] Multiple user profiles
- [ ] AI-powered personalized health recommendations
- [ ] Wearable device integration
- [ ] Social sharing of health achievements
- [ ] Widget support (home screen quick-view)

---

## 🤝 Contributing

Contributions are welcome and appreciated! Here's how to get started:

1. **Fork** the repository on GitHub.
2. **Clone** your fork: `git clone https://github.com/laith-alskaf/betterme_project.git`
3. **Create** a branch: `git checkout -b feature/your-feature-name`
4. **Make** your changes, following the code style guidelines below.
5. **Run** `flutter analyze` and fix any issues.
6. **Commit**: `git commit -m "feat: add your feature description"`
7. **Push**: `git push origin feature/your-feature-name`
8. **Open** a Pull Request and describe your changes.

### Code Style Guidelines

- Use **2-space** indentation
- Follow the [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Add **documentation comments** for all public methods
- Write **tests** for new features
- Use **meaningful commit messages** (prefer Conventional Commits)

### Reporting Issues

When opening an issue, please include:
- A clear description of the problem
- Steps to reproduce
- Your device/OS/Flutter version
- Error logs if applicable

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Flutter Team** for the amazing cross-platform framework
- **GetX Community** for the excellent state management solution
- **Open Source Contributors** who provided the dependencies used in this project

---

<div align="center">

**Made with ❤️ to help people live healthier lives**

[⬆️ Back to Top](#-betterme--health--wellness-application) • [🐙 GitHub](https://github.com/laith-alskaf/betterme_project) • [📥 Download APK](https://drive.google.com/drive/folders/1PTTms0S6cwumAz42Ib0R8BlxhqOSv6e1) • [📧 Report an Issue](https://github.com/laith-alskaf/betterme_project/issues)

⭐ If you find this project helpful, please give it a star!

</div>
