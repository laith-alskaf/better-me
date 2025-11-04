/// Application Configuration
/// جميع إعدادات التطبيق في مكان واحد
class AppConfig {
  AppConfig._(); // Private constructor

  // App Info
  static const String appName = 'BetterMe';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appDescription =
      'تطبيق شامل للصحة الشخصية يوفر نصائح صحية ومعلومات قيمة';

  // API Configuration (for future use)
  static const String baseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enableDebugLogs = true;
  static const bool enableCrashReports = false;

  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100;

  // Notification Configuration
  static const String channelId = 'com.betteme.medicine.reminder';
  static const String channelName = 'Medicine Reminders';
  static const String channelDescription =
      'تنبيهات تذكر بمواعيد الأدوية والعلاجات';

  // UI Configuration
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 4.0;

  // Animation Durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 400);
  static const Duration slowAnimation = Duration(milliseconds: 800);

  // Supported Languages
  static const List<String> supportedLanguages = ['ar', 'en'];
  static const String defaultLanguage = 'ar';
}