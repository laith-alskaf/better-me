<div align="center">

# 🏥 BetterMe - Health & Wellness Application

**A comprehensive Flutter application for health monitoring, medical calculations, and personalized health assistance**

[![Flutter](https://img.shields.io/badge/Flutter-3.3.1+-blue.svg?style=flat-square&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.3.1+-00796B.svg?style=flat-square&logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey.svg?style=flat-square)](https://flutter.dev/)

**[Features](#✨-key-features) • [Tech Stack](#⚙️-tech-stack) • [Setup](#🚀-quick-start) • [Documentation](#📚-documentation) • [Contributing](#🤝-contributing)**

</div>

---

## 📋 Overview

**BetterMe** is a feature-rich Flutter health and wellness application designed to empower users with health insights, personalized medical calculations, medication management, and AI-powered health assistance. Built with **Clean Architecture** and **GetX state management**, the app provides a seamless, responsive experience across Android and iOS platforms.

### What Does BetterMe Do?

- 📊 **7 Health Calculators**: BMI, Calories, Ideal Weight, Blood Pressure, Water Intake, Fat Consumption, Smoking Cost
- 💊 **Medicine Management**: Track medications with smart reminders and notifications
- 💬 **AI Chat Assistant**: Real-time Q&A powered by ChatGPT integration
- 🌍 **Multi-language Support**: Full Arabic/English localization with dynamic switching
- 🎨 **Modern UI/UX**: Responsive design with unified design system
- 📱 **Cross-Platform**: Native Android and iOS applications

---

## ✨ Key Features

### 🧮 Health Calculators (7 Tools)

| Calculator | Purpose | Inputs |
|-----------|---------|--------|
| **BMI Calculator** | Calculate Body Mass Index | Age, Height, Weight, Gender |
| **Calories Calculator** | Daily caloric intake | Activity level, Age, Weight |
| **Perfect Weight** | Ideal body weight | Height, Frame size |
| **Blood Pressure** | BP classification | Systolic, Diastolic readings |
| **Water Need** | Hydration requirements | Weight, Activity level |
| **Fat Eating** | Daily fat tracking | Age, Weight, Activity |
| **Smoking Cost** | Financial impact of smoking | Cigarettes/day, Price per pack |

### 💊 Medicine Management

- **Add/Edit/Delete Medicines**: Full CRUD operations
- **Smart Reminders**: Time-based and date-based notifications
- **Medicine Types**: Pills, Tablets, Capsules, Liquids, Injections, Sprays, Creams
- **Calendar Integration**: Visual medicine schedule
- **Timezone Support**: Accurate reminder timing across timezones

### 🤖 AI Health Assistant

- **ChatGPT Integration**: Ask personalized health questions
- **Real-time Responses**: Streaming chat interface
- **Connectivity Monitoring**: Offline detection
- **History Management**: Previous Q&A history

### 🌐 Localization & Theme

- **Languages**: 
  - 🇸🇦 Arabic (AR_SA) - RTL Support
  - 🇬🇧 English (EN_US) - LTR Support
- **Dynamic Switching**: Change language without app restart
- **150+ Translation Keys**: Comprehensive text coverage
- **Responsive Design**: Works on phones and tablets

---

## ⚙️ Tech Stack & Architecture

### Framework & Language

- **Framework**: Flutter 3.3.1+
- **Language**: Dart 3.3.1+
- **Architecture**: Clean Architecture with MVC pattern
- **State Management**: GetX (v4.6.5)
- **Dependency Injection**: GetX Bindings (automatic DI)

### Architecture Layers

`
┌─────────────────────────────────────┐
│         Presentation Layer          │
│    (Views, Controllers, Widgets)    │
├─────────────────────────────────────┤
│         Domain Layer                │
│    (Business Logic, Entities)       │
├─────────────────────────────────────┤
│         Data Layer                  │
│  (Services, Repositories, Models)   │
└─────────────────────────────────────┘
`

### Key Packages

#### State Management & Navigation
- **get** (^4.6.5): GetX - state management, routing, DI
- **provider** (^6.0.0): Alternative state management

#### UI & Design
- **flutter_svg** (^1.0.0): SVG rendering
- **sizer** (^2.0.15): Responsive sizing
- **lottie** (^2.6.0): Animations
- **google_nav_bar** (^5.0.6): Custom navigation bar
- **animated_notch_bottom_bar** (^1.0.0): Notched navigation
- **flutter_spinkit** (^5.2.0): Loading indicators

#### Data & Storage
- **shared_preferences** (^2.2.2): Key-value storage
- **json_annotation** (^4.8.1): JSON serialization
- **dartz** (^0.10.1): Functional programming (Either type)

#### Networking
- **dio**: HTTP client with interceptors
- **retrofit**: REST API code generation
- **connectivity_plus** (^5.0.2): Network status

#### Notifications & Utilities
- **flutter_local_notifications** (^14.1.1): Push notifications
- **table_calendar** (^3.0.9): Calendar widget
- **intl** (^0.19.0): Localization
- **timezone** (^0.9.2): Timezone management
- **awesome_dialog** (^3.0.2): Dialog components
- **bot_toast** (^4.0.2): Toast notifications

---

## 📁 Project Structure

`
lib/
├── main.dart                        # Application entry point
│
├── app/
│   ├── bindings/
│   │   └── app_bindings.dart        # Global service initialization
│   ├── my_app.dart                  # App configuration & theming
│   └── my_app_controller.dart
│
├── config/
│   ├── localization/
│   │   ├── localization_controller.dart
│   │   ├── app_localizations.dart   # 150+ translation keys
│   │   └── index.dart
│   ├── routes/
│   │   ├── app_pages.dart           # Route definitions
│   │   └── app_routes.dart          # Route constants
│   └── theme/
│       ├── app_colors.dart          # Color palette
│       ├── app_text_styles.dart     # Typography
│       ├── app_theme.dart           # Material theme
│       └── design_system.dart       # Design constants
│
├── core/
│   ├── constants/                   # App constants
│   ├── data/models/                 # Shared data models
│   ├── enums/                       # Enumerations
│   ├── extensions/                  # Dart extensions
│   ├── error/                       # Error handling
│   ├── services/                    # Core services
│   │   ├── connectivity_service.dart
│   │   ├── storage_service.dart
│   │   └── logger_service.dart
│   ├── utils/                       # Utility functions
│   └── widgets/                     # Deprecated - use shared/widgets
│
├── features/                        # Feature modules
│   ├── splash/
│   │   ├── controller/
│   │   └── view/
│   ├── home/
│   │   ├── controller/
│   │   └── view/
│   ├── calculator/                  # 7 calculators
│   │   ├── controller/
│   │   ├── view/
│   │   └── models/
│   ├── search_chat/
│   │   ├── controller/
│   │   └── view/
│   ├── medicine_reminder/
│   │   ├── controller/
│   │   ├── view/
│   │   └── models/
│   ├── medicine/                    # Legacy implementation
│   ├── bindings/
│   │   ├── home_binding.dart
│   │   ├── calculator_binding.dart
│   │   ├── search_binding.dart
│   │   └── medicine_binding.dart
│   └── main_view.dart               # Navigation hub
│
└── shared/
    ├── services/
    │   └── local_notification_service.dart
    ├── utils/
    │   └── utils.dart
    └── widgets/
        ├── unified_widgets.dart     # Consolidated UI components
        ├── custom_navigation_bar.dart
        ├── custom_toast.dart
        └── index.dart
`

---

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK**: 3.3.1 or higher
- **Dart SDK**: 3.3.1 or higher
- **Android Studio** or **Xcode** (for platform-specific setup)
- **Git**: For version control

### Installation

#### 1️⃣ **Clone the Repository**

`ash
git clone https://github.com/yourusername/betterme.git
cd betterme
`

#### 2️⃣ **Install Dependencies**

`ash
flutter clean
flutter pub get
`

#### 3️⃣ **Generate Code (if using code generation)**

`ash
flutter pub run build_runner build
`

#### 4️⃣ **Run the Application**

`ash
# Development build
flutter run

# Release build (Android)
flutter build apk --release

# Release build (iOS)
flutter build ios --release

# Release build (App Bundle for Google Play)
flutter build appbundle --release
`

### Platform-Specific Setup

#### Android Setup
- **Min SDK**: 24 (Android 7.0)
- **Target SDK**: Latest (automated by Flutter)
- **Package Name**: com.example.betterme
- **Signing**: Configure keystore for production builds

#### iOS Setup
- **Deployment Target**: iOS 11.0+
- **Swift Version**: 5.0+
- **Xcode Build**: lutter build ios --release

---

## 📚 Documentation

### Core Concepts

#### State Management with GetX

`dart
// Define a controller
class HomeController extends GetxController {
  var count = 0.obs;  // Reactive variable
  
  void increment() {
    count++;  // Automatic UI rebuild
  }
}

// Use in widget
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    
    return Obx(() => Text('Count: \'));
  }
}
`

#### Navigation

`dart
// Named navigation
Get.toNamed(AppRoutes.calculator);

// Passing parameters
Get.toNamed(AppRoutes.medicineDetails, arguments: medicineId);

// Going back
Get.back();

// Replace current route
Get.off(AppRoutes.home);
`

#### Localization

`dart
// Using translations
Text('welcome'.tr)  // Returns localized text

// Switching language
LocalizationController.instance.changeLanguage(Locale('ar', 'SA'));

// Check current language
bool isArabic = LocalizationController.instance.isArabic;

// Add new translation key
// Edit: lib/config/localization/app_localizations.dart
'my_new_key': 'English text',  // English
'my_new_key': 'النص العربي',   // Arabic
`

#### Design System

`dart
// Use predefined spacing
Padding(
  padding: DesignSystem.paddingBase,
  child: child,
)

// Use button height
SizedBox(
  height: DesignSystem.buttonHeightMedium,
  child: AppButton(...),
)

// Use border radius
Container(
  decoration: BoxDecoration(
    borderRadius: DesignSystem.borderRadiusMedium,
  ),
)
`

### File Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Dart Files | snake_case | home_controller.dart |
| Classes | PascalCase | class HomeController |
| Constants | camelCase | const maxRetries = 3 |
| Variables | camelCase | ar userName = '' |
| Views | Suffix with View | HomeView |
| Controllers | Suffix with Controller | HomeController |
| Bindings | Suffix with Binding | HomeBinding |

### API Integration

The app uses **Dio** and **Retrofit** for API calls:

`dart
// Define API interface
@RestApi(baseUrl: 'https://api.example.com')
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET('/health/advice')
  Future<HealthResponse> getHealthAdvice(@Query('query') String query);
}

// Use in controller
class SearchController extends GetxController {
  final apiClient = Get.find<ApiClient>();

  void searchHealth(String query) async {
    try {
      var response = await apiClient.getHealthAdvice(query);
      // Handle response
    } catch (e) {
      // Handle error
    }
  }
}
`

---

## 🧪 Testing

### Running Tests

`ash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage

# Watch mode (re-run tests on file changes)
flutter test --watch
`

### Test Structure

- **Unit Tests**: 	est/models/
- **Widget Tests**: 	est/widget_test.dart
- **Integration Tests**: Not yet implemented (future)

### Writing Tests

`dart
void main() {
  group('Medicine Model Tests', () {
    test('Medicine should create instance correctly', () {
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
`

---

## 🛠️ Development

### Code Analysis

`ash
# Run Dart analyzer
flutter analyze

# Format code
dart format lib/

# Check for lint issues
flutter pub pub lint
`

### Build Configuration Files

| File | Purpose |
|------|---------|
| pubspec.yaml | Dependencies and project metadata |
| nalysis_options.yaml | Lint rules and code style |
| ndroid/app/build.gradle.kts | Android build configuration |
| ios/Podfile | iOS dependencies |

### Creating a New Feature

1. **Create feature structure**:
   `ash
   mkdir -p lib/features/new_feature/{controller,view,model}
   `

2. **Create controller**:
   `dart
   class NewFeatureController extends GetxController {}
   `

3. **Create view**:
   `dart
   class NewFeatureView extends StatelessWidget {}
   `

4. **Create binding**:
   `dart
   class NewFeatureBinding extends Bindings {
     @override
     void dependencies() {
       Get.lazyPut(() => NewFeatureController());
     }
   }
   `

5. **Add route** in lib/config/routes/app_pages.dart:
   `dart
   GetPage(
     name: AppRoutes.newFeature,
     page: () => const NewFeatureView(),
     binding: NewFeatureBinding(),
   )
   `

---

## 🎨 Theming

### Color Palette

Colors are defined in lib/config/theme/app_colors.dart:

`dart
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryLight = Color(0xFF9C27B0);
  
  // Secondary colors
  static const Color secondary = Color(0xFF03DAC6);
  
  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF757575);
}
`

### Custom Theming

To customize the app theme:

1. Edit lib/config/theme/app_colors.dart - Change colors
2. Edit lib/config/theme/app_text_styles.dart - Change typography
3. Edit lib/config/theme/design_system.dart - Change spacing/sizing
4. Rebuild: lutter clean && flutter pub get && flutter run

---

## 📱 Features by Module

### Splash Module
- Initializes services
- Displays branding
- Transitions to home

### Home Module
- Feature grid dashboard
- Quick access to all modules
- User profile (if implemented)

### Calculator Module
- 7 independent calculators
- Input validation
- Result display with interpretation

### Search & Chat Module
- Real-time ChatGPT integration
- Q&A history
- Network connectivity check

### Medicine Reminder Module
- Medicine CRUD operations
- Scheduled notifications
- Calendar view
- Reminder history

---

## 🚨 Troubleshooting

### Common Issues

#### Build Fails
`ash
# Clear build artifacts
flutter clean
flutter pub get
flutter pub run build_runner build
flutter run
`

#### Hot Reload Not Working
`ash
# Restart the app
flutter run --no-fast-start
`

#### Android Build Issues
`ash
# Update dependencies
flutter pub get

# Invalidate Android cache
rm -rf android/.gradle
flutter clean
flutter run
`

#### iOS Build Issues
`ash
# Update pod dependencies
cd ios
pod update
cd ..
flutter run
`

---

## 📊 Performance

| Metric | Target | Notes |
|--------|--------|-------|
| **App Startup Time** | < 500ms | Optimized with permanent bindings |
| **Memory Usage** | < 100MB | Efficient state management |
| **Build Time** | < 2min | Dev build (depends on machine) |
| **Frame Rate** | 60 FPS | Smooth animations and transitions |

---

## 🔒 Security

- ✅ **HTTPS Only**: All API calls use secure connections
- ✅ **Input Validation**: All user inputs are validated
- ✅ **Local Storage**: Sensitive data uses encrypted storage
- ✅ **Permissions**: Request only necessary permissions
- ✅ **Code Obfuscation**: Enabled for release builds

---

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **GetX Community** for excellent state management
- **Open Source Contributors** who provided dependencies
- **Users** for feedback and feature requests

---

## 📈 Roadmap

- [ ] Offline mode for calculators
- [ ] Cloud sync for medicine reminders
- [ ] Wearable device integration
- [ ] AI-powered health recommendations
- [ ] Social sharing of health achievements
- [ ] Dark mode support
- [ ] Multiple user profiles

---

<div align="center">

**Made with ❤️ by the BetterMe Team**

⭐ If you find this project helpful, please star it!

</div>
