import 'dart:math' show pow;

/// Number Extensions
/// توسيعات مفيدة للـ int و double
extension NumExtensions on num {
  /// Convert to percentage string
  String toPercentage({int decimals = 0}) {
    return '${toStringAsFixed(decimals)}%';
  }

  /// Check if even (for int)
  bool get isEven => this % 2 == 0;

  /// Check if odd (for int)
  bool get isOdd => this % 2 != 0;

  /// Check if positive
  bool get isPositive => this > 0;

  /// Check if negative
  bool get isNegative => this < 0;

  /// Check if zero
  bool get isZero => this == 0;

  /// Get absolute value
  num get absValue => this.abs();

  /// Round to decimal places
  double roundToDecimal(int decimals) {
    final mod = pow(10.0, decimals).toInt();
    return (this * mod).round() / mod;
  }

  /// Format as currency (basic)
  String formatAsCurrency({String symbol = '\$', int decimals = 2}) {
    return '$symbol${toStringAsFixed(decimals)}';
  }

  /// Format as compact number (e.g., 1000 -> 1K)
  String formatAsCompact() {
    if (absValue >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (absValue >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }

  /// Convert to time string (seconds to HH:MM:SS)
  String toTimeString() {
    final seconds = this as int;
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  /// Clamp value between min and max
  num clamp(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
}