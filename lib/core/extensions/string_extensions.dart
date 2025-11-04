/// String Extensions
/// توسيعات مفيدة للـ String
extension StringExtensions on String {
  /// Check if string is empty or null
  bool get isEmpty => this.isEmpty;

  /// Check if string is not empty
  bool get isNotEmpty => this.isNotEmpty;

  /// Check if string is numeric
  bool get isNumeric => num.tryParse(this) != null;

  /// Check if string is email
  bool get isEmail {
    return RegExp(
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(this);
  }

  /// Check if string is URL
  bool get isUrl {
    return RegExp(
            r'^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&/=]*)$')
        .hasMatch(this);
  }

  /// Check if string contains only letters
  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if string contains only alphabetic characters and spaces
  bool get isAlphaWithSpaces =>
      RegExp(r'^[a-zA-Z\s]+$').hasMatch(this);

  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalize each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty
            ? word
            : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }

  /// Remove extra spaces
  String get removeExtraSpaces {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Reverse string
  String get reverse {
    return split('').reversed.join('');
  }

  /// Remove special characters
  String get removeSpecialCharacters {
    return replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  /// Check if palindrome
  bool get isPalindrome {
    final cleaned = removeSpecialCharacters.replaceAll(' ', '').toLowerCase();
    return cleaned == cleaned.reverse;
  }

  /// Get character count by type
  Map<String, int> get characterCount {
    int letters = 0, digits = 0, special = 0, spaces = 0;
    for (final char in split('')) {
      if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
        letters++;
      } else if (RegExp(r'\d').hasMatch(char)) {
        digits++;
      } else if (char == ' ') {
        spaces++;
      } else {
        special++;
      }
    }
    return {
      'letters': letters,
      'digits': digits,
      'special': special,
      'spaces': spaces,
    };
  }

  /// Truncate string
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Check if contains substring (case insensitive)
  bool containsIgnoreCase(String substring) {
    return toLowerCase().contains(substring.toLowerCase());
  }

  /// Split by multiple delimiters
  List<String> splitByMultiple(List<String> delimiters) {
    List<String> result = [this];
    for (final delimiter in delimiters) {
      result = result
          .expand((element) => element.split(delimiter))
          .toList();
    }
    return result;
  }

  /// Convert to double safely
  double? toDoubleOrNull() => double.tryParse(this);

  /// Convert to int safely
  int? toIntOrNull() => int.tryParse(this);

  /// Get initials from string (e.g., "Muhammad Ahmed" -> "MA")
  String get initials {
    if (isEmpty) return '';
    return split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join('')
        .substring(0, 2.clamp(0, 2));
  }

  /// Format as phone number (simple formatter)
  String formatAsPhoneNumber() {
    if (length < 10) return this;
    return '+${substring(0, length - 10).padLeft(1, '0')} ${substring(length - 10, length - 7)}-${substring(length - 7, length - 4)}-${substring(length - 4)}';
  }
}