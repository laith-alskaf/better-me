/// Base class لجميع أنواع الأخطاء في التطبيق
abstract class Failure {
  final String message;
  final dynamic error;

  const Failure(this.message, [this.error]);

  @override
  String toString() => 'Failure: $message ${error != null ? '($error)' : ''}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message && other.error == error;
  }

  @override
  int get hashCode => message.hashCode ^ error.hashCode;
}

// ==================== Server Failures ====================

/// خطأ في الخادم أو API
class ServerFailure extends Failure {
  const ServerFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'ServerFailure: $message ${error != null ? '($error)' : ''}';
}

/// خطأ في الاتصال بالإنترنت
class NetworkFailure extends Failure {
  const NetworkFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'NetworkFailure: $message ${error != null ? '($error)' : ''}';
}

/// خطأ في المصادقة (Authentication)
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'AuthenticationFailure: $message ${error != null ? '($error)' : ''}';
}

// ==================== Cache/Storage Failures ====================

/// خطأ في التخزين المحلي (SharedPreferences, Hive, etc.)
class CacheFailure extends Failure {
  const CacheFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'CacheFailure: $message ${error != null ? '($error)' : ''}';
}

/// خطأ في قراءة البيانات
class DataParsingFailure extends Failure {
  const DataParsingFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'DataParsingFailure: $message ${error != null ? '($error)' : ''}';
}

// ==================== Validation Failures ====================

/// خطأ في التحقق من صحة البيانات (Validation)
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure(
    String message, {
    this.fieldErrors,
    dynamic error,
  }) : super(message, error);

  @override
  String toString() {
    final baseMessage = 'ValidationFailure: $message';
    if (fieldErrors != null && fieldErrors!.isNotEmpty) {
      return '$baseMessage - Fields: ${fieldErrors.toString()}';
    }
    return baseMessage;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValidationFailure &&
        other.message == message &&
        other.error == error &&
        other.fieldErrors == fieldErrors;
  }

  @override
  int get hashCode => message.hashCode ^ error.hashCode ^ fieldErrors.hashCode;
}

// ==================== Business Logic Failures ====================

/// خطأ في منطق الأعمال (Business Logic)
class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'BusinessLogicFailure: $message ${error != null ? '($error)' : ''}';
}

/// العنصر غير موجود
class NotFoundFailure extends Failure {
  const NotFoundFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'NotFoundFailure: $message ${error != null ? '($error)' : ''}';
}

/// خطأ في الصلاحيات (Permissions)
class PermissionFailure extends Failure {
  const PermissionFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'PermissionFailure: $message ${error != null ? '($error)' : ''}';
}

// ==================== Generic Failures ====================

/// خطأ غير معروف أو غير محدد
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'UnexpectedFailure: $message ${error != null ? '($error)' : ''}';
}

/// خطأ في العملية (Operation)
class OperationFailure extends Failure {
  const OperationFailure(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'OperationFailure: $message ${error != null ? '($error)' : ''}';
}