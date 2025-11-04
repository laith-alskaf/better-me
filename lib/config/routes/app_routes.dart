/// App Routes Configuration
/// جميع المسارات والروابط في التطبيق
class AppRoutes {
  AppRoutes._(); // Private constructor

  // Splash Screen
  static const String splash = '/splash';

  // Main Navigation
  static const String home = '/home';
  static const String mainView = '/main';

  // Medicine Reminder Routes
  static const String medicineReminder = '/medicine-reminder';
  static const String addMedicine = '/add-medicine';
  static const String editMedicine = '/edit-medicine';
  static const String medicineDetails = '/medicine-details';

  // Calculator Routes
  static const String calculator = '/calculator';
  static const String bmiCalculator = '/bmi-calculator';
  static const String caloriesCalculator = '/calories-calculator';
  static const String idealWeightCalculator = '/ideal-weight-calculator';

  // Search & Chat Routes
  static const String search = '/search';
  static const String chatGPT = '/chat-gpt';
  static const String healthTips = '/health-tips';

  // Settings Routes
  static const String settings = '/settings';
  static const String language = '/language';
  static const String notifications = '/notifications';
  static const String about = '/about';

  // Auth Routes (for future use)
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';

  /// Get initial route
  static const String initialRoute = splash;
}