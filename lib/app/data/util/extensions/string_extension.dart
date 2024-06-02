part of 'index.dart';

/// Dart extension to add utility functions to [String] class.
extension ExString on String {
  /// Removes the last character of a string if it matches [lastChar].
  ///
  /// Example:
  /// ```dart
  /// String example = 'Hello,';
  /// print(example.removeLastIf(lastChar: ',')); // prints 'Hello'
  /// ```
  ///
  /// - Parameter [lastChar]: The character to be removed if present at the end of the string.
  /// - Returns: A new string with the last character removed if it matches [lastChar], else returns the same string.
  String removeLastIf({required String lastChar}) {
    if (endsWith(lastChar)) {
      return substring(0, length - 1);
    }

    return this;
  }
}

/// Dart extension to add utility functions to nullable [String]
extension ExStringNull on String? {
  /// Checks if a nullable string is null or empty.
  ///
  /// Example:
  /// ```dart
  /// String? example = null;
  /// print(example.isNullOrEmpty); // prints 'true'
  /// ```
  ///
  /// - Returns: `true` if the string is `null` or empty, `false` otherwise.
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }

    return this! == 'null' || this!.isEmpty;
  }

  /// Replaces many substrings to their respective provided replacements.
  ///
  /// Example:
  /// ```dart
  /// String? example = 'Hello, world!';
  /// print(example.replaceMany([{ look: 'Hello', replacement: 'Hi' }, { look: 'world', replacement: 'earth' }])); // prints 'Hi, earth!'
  /// ```
  ///
  /// - Parameter items: List of objects with two properties `look` and `replacement`. All occurrences of `look` in the string will be replaced by the `replacement`.
  /// - Returns: A new string with all replacements made.
  String replaceMany(List<({String look, String replacement})> items) {
    String temp = this ?? '';
    for (({String look, String replacement}) item in items) {
      temp = temp.replaceAll(item.look, item.replacement);
    }

    return temp;
  }
}
