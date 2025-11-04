/// Application Constants
/// جميع الثوابت المستخدمة في التطبيق
class AppConstants {
  AppConstants._(); // Private constructor

  // ============ Medicine Reminders ============
  static const String medicineListKey = 'medicines_list';
  static const String medicineReminderChannelId = 'medicine_reminders';
  static const String medicineReminderChannelName = 'Medicine Reminders';

  // ============ Chat GPT ============
  static const String chatListAnswerKey = 'chat_list_answer';
  static const String chatListQuestionsKey = 'chat_list_questions';
  static const String chatGPTModel = 'gpt-3.5-turbo';

  // ============ User Preferences ============
  static const String userLanguageKey = 'user_language';
  static const String userThemeKey = 'user_theme';
  static const String userFirstLaunchKey = 'user_first_launch';
  static const String userNameKey = 'user_name';
  static const String userAgeKey = 'user_age';
  static const String userGenderKey = 'user_gender';
  static const String userHeightKey = 'user_height';
  static const String userWeightKey = 'user_weight';

  // ============ Health Metrics ============
  static const double maleIdealWeightFactor = 50; // kg for 150cm height
  static const double femaleIdealWeightFactor = 45; // kg for 150cm height
  static const double bmiUnderweight = 18.5;
  static const double bmiNormalMax = 24.9;
  static const double bmiOverweightMax = 29.9;
  static const double bmiObeseMax = 40.0;

  // ============ Notification Settings ============
  static const String notificationEnabledKey = 'notifications_enabled';
  static const String notificationSoundKey = 'notification_sound';
  static const String notificationVibrateKey = 'notification_vibrate';

  // ============ Cache Configuration ============
  static const String lastSyncKey = 'last_sync';
  static const int cacheExpirationMinutes = 1440; // 24 hours

  // ============ Validation Rules ============
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const int minAgeAllowed = 13;
  static const int maxAgeAllowed = 120;
  static const double minHeightCM = 100;
  static const double maxHeightCM = 250;
  static const double minWeightKG = 30;
  static const double maxWeightKG = 300;

  // ============ Animations ============
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration normalAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
}

/// API Response Keys
class ApiResponseKeys {
  ApiResponseKeys._();

  static const String statusKey = 'status';
  static const String messageKey = 'message';
  static const String dataKey = 'data';
  static const String errorKey = 'error';
  static const String codeKey = 'code';
}

/// Gender Types
class GenderTypes {
  GenderTypes._();

  static const String male = 'male';
  static const String female = 'female';
  static const String other = 'other';

  static List<String> get allValues => [male, female, other];
}

/// App Strings - Will be replaced with localization
class AppStrings {
  AppStrings._();

  // General
  static const String appName = 'BetterMe';
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String previous = 'Previous';

  // Navigation
  static const String home = 'Home';
  static const String calculator = 'Calculator';
  static const String search = 'Search';
  static const String medicines = 'Medicines';

  // Medicine
  static const String medicineName = 'Medicine Name';
  static const String dosage = 'Dosage';
  static const String frequency = 'Frequency';
  static const String addMedicine = 'Add Medicine';
  static const String removeMedicine = 'Remove Medicine';

  // Calculator
  static const String bmi = 'BMI';
  static const String idealWeight = 'Ideal Weight';
  static const String calories = 'Calories';
  static const String height = 'Height (cm)';
  static const String weight = 'Weight (kg)';

  // Errors
  static const String errorOccurred = 'An error occurred';
  static const String noInternetConnection = 'No internet connection';
  static const String fieldRequired = 'This field is required';
  static const String invalidEmail = 'Invalid email address';
}