import 'package:flutter/material.dart';

/// Context Extensions
/// توسيعات مفيدة للـ BuildContext
extension ContextExtensions on BuildContext {
  /// Get media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => mediaQuery.size;

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height
  double get screenHeight => screenSize.height;

  /// Get device padding (notch, safe area)
  EdgeInsets get padding => mediaQuery.padding;

  /// Get device view insets (keyboard)
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Check if screen is in landscape
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Check if screen is in portrait
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Check if device is in dark mode
  bool get isDarkMode => mediaQuery.platformBrightness == Brightness.dark;

  /// Get text scale factor
  double get textScaleFactor => mediaQuery.textScaleFactor;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  /// Get keyboard height
  double get keyboardHeight => viewInsets.bottom;

  /// Get theme data
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Pop current route
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Push a named route
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Replace current route
  Future<T?> pushReplacementNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
    T? result,
  }) {
    return Navigator.of(this).pushReplacementNamed<T, T>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Show snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Request focus
  void requestFocus(FocusNode node) {
    FocusScope.of(this).requestFocus(node);
  }

  /// Unfocus
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}