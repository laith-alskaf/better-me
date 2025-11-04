/// Logger Service
/// توفر طريقة موحدة لتسجيل الأحداث والأخطاء

class LoggerService {
  static const String _prefix = '[BetterMe]';

  /// Log debug message
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    final log = '$_prefix [DEBUG] $message';
    if (error != null) {
      print('$log\nError: $error');
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    } else {
      print(log);
    }
  }

  /// Log info message
  static void info(String message) {
    print('$_prefix [INFO] $message');
  }

  /// Log warning message
  static void warning(String message, [dynamic error]) {
    final log = '$_prefix [WARNING] $message';
    if (error != null) {
      print('$log\nError: $error');
    } else {
      print(log);
    }
  }

  /// Log error message
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    final log = '$_prefix [ERROR] $message';
    print(log);
    if (error != null) {
      print('Error Details: $error');
    }
    if (stackTrace != null) {
      print('StackTrace: $stackTrace');
    }
  }

  /// Log success message
  static void success(String message) {
    print('$_prefix [SUCCESS] ✓ $message');
  }
}