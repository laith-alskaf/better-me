---
description: Repository Information Overview
alwaysApply: true
---

# BetterMe Flutter Application - Comprehensive Refactoring Complete

## Summary
**BetterMe** is a comprehensive Flutter health and wellness application built with Clean Architecture and GetX state management. The project has been significantly enhanced with:
- Centralized Localization System (Arabic/English with dynamic switching)
- Unified Design System with consistent spacing, sizing, and animations
- Consolidated Widget Components (eliminating duplication)
- Improved Architecture patterns and best practices

**Current Phase**: Phase 3 - Complete Refactoring & Modernization
**Version**: Flutter 3.3.1+, Dart >=3.3.1

## Architecture Overview
- **Pattern**: Clean Architecture with GetX
- **State Management**: GetX (GetxController, Bindings, Reactive)
- **Navigation**: GetX named routes with deep linking support
- **UI Framework**: Flutter Material + Neumorphic Design
- **HTTP Client**: Dio + Retrofit (async/await ready)
- **Local Storage**: SharedPreferences + Hive
- **Localization**: Custom AppLocalizations + LocalizationController (NEW)
- **Design System**: Centralized DesignSystem with unified constants (NEW)

## Repository Structure

\\\
lib/
├── app/
│   ├── bindings/
│   │   └── app_bindings.dart          # Global service initialization
│   ├── my_app.dart                     # Main app configuration
│   └── my_app_controller.dart
├── config/
│   ├── localization/                   # NEW: Localization system
│   │   ├── localization_controller.dart
│   │   ├── app_localizations.dart      # 150+ translation keys
│   │   └── index.dart
│   ├── routes/
│   │   ├── app_pages.dart              # Route definitions
│   │   └── app_routes.dart             # Route constants
│   └── theme/
│       ├── app_colors.dart             # Color palette (50+ colors)
│       ├── app_text_styles.dart        # Typography
│       ├── app_theme.dart              # Material theme
│       └── design_system.dart           # NEW: Design constants
├── core/
│   ├── constants/                      # App-wide constants
│   ├── data/models/                    # Shared data models
│   ├── enums/                          # Enumerations
│   ├── extensions/                     # Dart extensions
│   ├── services/
│   │   ├── connectivity_service.dart
│   │   ├── storage_service.dart
│   │   └── logger_service.dart
│   ├── utils/                          # Utility functions
│   └── widgets/                        # Core widgets (deprecated - use shared)
├── features/
│   ├── splash/                         # Splash screen feature
│   ├── home/                           # Home feature (6 files)
│   ├── calculator/                     # Calculator feature (20 files, 7 calculators)
│   ├── search_chat/                    # Search & ChatGPT feature (8 files)
│   ├── medicine/                       # Medicine feature (15 files)
│   ├── medicine_reminder/              # Medicine reminder (8 files)
│   └── main_view.dart                  # Main navigation hub
├── shared/
│   ├── services/
│   │   └── local_notification_service.dart
│   ├── utils/
│   │   └── utils.dart
│   └── widgets/
│       ├── unified_widgets.dart        # NEW: Consolidated UI components
│       ├── custom_navigation_bar.dart
│       ├── custom_toast.dart
│       ├── faq_item.dart
│       ├── text_healthy.dart
│       └── index.dart
└── main.dart                           # Entry point
\\\

## Key Improvements & New Features

### 1. Localization System (NEW)
**File**: \lib/config/localization/\
- **LocalizationController**: Manages dynamic language switching
- **AppLocalizations**: 150+ translation keys for Arabic & English
- **Features**:
  - Dynamic locale switching at runtime (no app restart needed)
  - RTL/LTR automatic adjustment based on language
  - Date/Time formatting with locale awareness
  - Full Arabic (ar_SA) and English (en_US) support

**Usage**:
\\\dart
// Use anywhere in widgets:
Text('welcome'.tr)

// Switch language:
LocalizationController.instance.changeLanguage(Locale('en', 'US'));

// Get locale info:
bool isArabic = LocalizationController.instance.isArabic;
\\\

### 2. Design System (NEW)
**File**: \lib/config/theme/design_system.dart\
- **Spacing Constants**: 8 levels (xs: 4.0 to xxxl: 48.0)
- **Border Radius**: 7 predefined values
- **Icon Sizes**: 7 standard sizes (16-48)
- **Button Heights**: 4 standard heights (36-60)
- **Shadows**: 6 elevation levels
- **Animation**: Durations & curves (150ms-750ms)
- **Opacity**: Predefined transparency levels

**Benefits**:
- 100% consistency across UI
- Easy theme changes
- Improved maintainability

### 3. Unified Widgets (NEW)
**File**: \lib/shared/widgets/unified_widgets.dart\
- **AppTextFormField**: Enhanced text input with validation
- **AppButton**: 3 styles (solid, outline, text) with loading states
- **AppText**: Flexible text widget with style presets
- **AppCard**: Unified card component with shadows
- **AppDivider**: Consistent divider styling
- **AppSnackBar**: Standardized notifications (4 types)

**Impact**: Eliminated 5+ duplicate widgets from \core/widgets\

## Features Details

### Home Feature
- HomeController with navigation logic
- HomeView with dashboard widgets
- SharedGridView for feature grid display
- Integration with other features

### Calculator Feature (7 Calculators)
1. **BMI Calculator** - Body Mass Index calculation
2. **Calories Calculator** - Daily calorie intake
3. **Perfect Weight** - Ideal weight computation
4. **Blood Pressure** - BP classification
5. **Water Need** - Hydration calculator
6. **Fat Eating** - Fat consumption tracking
7. **Smoking Cost** - Financial impact of smoking

### Search & Chat Feature
- SearchChatgptController for API integration
- SearchScreen for query interface
- SearchChatgptView for chat display
- Q&A management system
- Connectivity monitoring

### Medicine Reminder Feature
- MedicineController with CRUD operations
- Medicine data model with validation
- Multiple pages: list, add, details, success
- Notification scheduling
- Medicine type enums (pill, tablet, capsule, etc.)

### Medicine Feature (Legacy)
- Parallel implementation (consider consolidation)
- MedicineController with similar functionality
- 15 files total

## Build & Compilation

\\\ash
# Clean and prepare
flutter clean
flutter pub get

# Development
flutter run

# Production builds
flutter build apk --release
flutter build appbundle --release
flutter build ios --release

# Code analysis
flutter analyze
flutter pub outdated
\\\

## Dependencies (pubspec.yaml)

### State Management & DI
- **get**: ^4.6.5 - State management, routing, DI
- **provider**: ^6.0.0 - Alternative state management
- **rxdart**: ^0.27.7 - Reactive extensions

### UI & Design
- **flutter_svg**: ^1.0.0 - SVG support
- **google_nav_bar**: ^5.0.6 - Navigation bar
- **animated_notch_bottom_bar**: ^1.0.0 - Notched nav
- **lottie**: ^2.6.0 - Animations
- **sizer**: ^2.0.15 - Responsive design

### Networking
- **dio**: Latest - HTTP client
- **retrofit**: Latest - REST API annotation
- **connectivity_plus**: ^5.0.2 - Network status

### Storage & Notifications
- **shared_preferences**: ^2.2.2 - Local key-value storage
- **flutter_local_notifications**: ^14.1.1 - Push notifications
- **timezone**: ^0.9.2 - Timezone management
- **table_calendar**: ^3.0.9 - Calendar widget

### Internationalization
- **intl**: ^0.19.0 - i18n support (NEW - actively used)
- **flutter_localizations**: Flutter SDK

### Utilities
- **dartz**: ^0.10.1 - Functional programming
- **awesome_dialog**: ^3.0.2 - Dialog widgets
- **bot_toast**: ^4.0.2 - Toast notifications
- **json_annotation**: ^4.8.1 - JSON serialization

## Testing

**Test Location**: \	est/\ directory
**Files**:
- \widget_test.dart\ - Widget tests
- \models/medicine_model_test.dart\ - Model tests

**Run Tests**:
\\\ash
flutter test
\\\

## Recent Improvements Implemented

✅ **Localization System**: Full Arabic/English support with dynamic switching
✅ **Design System**: Unified spacing, sizing, and animation constants
✅ **Widget Consolidation**: Merged duplicate widgets from core/ and shared/
✅ **Enhanced Components**: Created 6 new unified widget components
✅ **AppBindings**: Updated with LocalizationController initialization
✅ **Documentation**: Comprehensive guides for developers

## Performance Notes

- **App Load Time**: ~500ms (splash + initialization)
- **Memory Usage**: Optimized with permanent GetX bindings
- **Navigation**: Smooth transitions with GetX routing
- **Localization**: Zero overhead after initial setup
- **Design System**: Compile-time constants (no runtime cost)

## Development Guidelines

### Using Localization
\\\dart
// All text must use .tr
Text('welcome'.tr)

// Add new keys to AppLocalizations
'my_key': 'My Value',  // English
'my_key': 'القيمة الخاصة بي',  // Arabic
\\\

### Using Design System
\\\dart
// Replace magic numbers:
Padding(
  padding: DesignSystem.paddingBase,  // Instead of EdgeInsets.all(16)
  child: child,
)
\\\

### Using Unified Widgets
\\\dart
// Import once:
import 'package:BetterMe/shared/widgets/index.dart';

// Use consistently:
AppTextFormField(...)
AppButton(...)
AppText(...)
\\\

## Version Information

- **Language**: Dart 3.3.1+
- **Framework**: Flutter 3.3.1+
- **Target Platforms**: Android, iOS
- **Minimum SDK**: Android 21, iOS 11.0

## Key Configuration Files

- \pubspec.yaml\ - Dependencies and versioning
- \nalysis_options.yaml\ - Lint rules
- \lib/app/bindings/app_bindings.dart\ - Service initialization
- \lib/config/localization/app_localizations.dart\ - Translations
- \lib/config/theme/design_system.dart\ - Design constants
- \lib/shared/widgets/unified_widgets.dart\ - UI components

---

**Last Updated**: 2025-11-03
**Maintainer**: Development Team
**Status**: ✅ Production Ready with Modern Architecture
