/// Base class لجميع الاستثناءات المخصصة في التطبيق
/// الاستثناءات تُستخدم في Data Layer
/// ويتم تحويلها إلى Failures في Repository Layer
abstract class AppException implements Exception {
  final String message;
  final dynamic error;

  const AppException(this.message, [this.error]);

  @override
  String toString() => 'AppException: $message ${error != null ? '($error)' : ''}';
}

// ==================== Server Exceptions ====================

/// استثناء في الخادم أو API
class ServerException extends AppException {
  final int? statusCode;

  const ServerException(
    String message, {
    this.statusCode,
    dynamic error,
  }) : super(message, error);

  @override
  String toString() {
    final baseMessage = 'ServerException: $message';
    if (statusCode != null) {
      return '$baseMessage (Status: $statusCode)';
    }
    return baseMessage;
  }
}

/// استثناء في الاتصال بالإنترنت
class NetworkException extends AppException {
  const NetworkException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'NetworkException: $message ${error != null ? '($error)' : ''}';
}

/// استثناء في المصادقة
class AuthenticationException extends AppException {
  const AuthenticationException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'AuthenticationException: $message ${error != null ? '($error)' : ''}';
}

/// استثناء في الترخيص (Authorization)
class AuthorizationException extends AppException {
  const AuthorizationException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'AuthorizationException: $message ${error != null ? '($error)' : ''}';
}

// ==================== Cache/Storage Exceptions ====================

/// استثناء في التخزين المحلي
class CacheException extends AppException {
  const CacheException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'CacheException: $message ${error != null ? '($error)' : ''}';
}

/// استثناء في قراءة/كتابة البيانات
class StorageException extends AppException {
  const StorageException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'StorageException: $message ${error != null ? '($error)' : ''}';
}

/// استثناء في تحليل البيانات (Parsing/Serialization)
class ParsingException extends AppException {
  const ParsingException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'ParsingException: $message ${error != null ? '($error)' : ''}';
}

// ==================== Validation Exceptions ====================

/// استثناء في التحقق من صحة البيانات
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException(
    String message, {
    this.fieldErrors,
    dynamic error,
  }) : super(message, error);

  @override
  String toString() {
    final baseMessage = 'ValidationException: $message';
    if (fieldErrors != null && fieldErrors!.isNotEmpty) {
      return '$baseMessage - Fields: ${fieldErrors.toString()}';
    }
    return baseMessage;
  }
}

// ==================== Business Logic Exceptions ====================

/// استثناء في منطق الأعمال
class BusinessException extends AppException {
  const BusinessException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'BusinessException: $message ${error != null ? '($error)' : ''}';
}

/// العنصر غير موجود
class NotFoundException extends AppException {
  const NotFoundException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'NotFoundException: $message ${error != null ? '($error)' : ''}';
}

/// العنصر موجود بالفعل (Duplicate)
class DuplicateException extends AppException {
  const DuplicateException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'DuplicateException: $message ${error != null ? '($error)' : ''}';
}

// ==================== Permission Exceptions ====================

/// استثناء في الصلاحيات
class PermissionException extends AppException {
  const PermissionException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'PermissionException: $message ${error != null ? '($error)' : ''}';
}

// ==================== Generic Exceptions ====================

/// استثناء غير متوقع
class UnexpectedException extends AppException {
  const UnexpectedException(String message, [dynamic error]) : super(message, error);

  @override
  String toString() => 'UnexpectedException: $message ${error != null ? '($error)' : ''}';
}