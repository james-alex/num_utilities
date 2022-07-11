import 'dart:math' as math;

/// Extends [num] with additional basic methods.
extension NumUtilities on num {
  /// `true` if the number is positive; otherwise, `false`.
  bool get isPositive => !isNegative;

  /// Returns `true` if [other] equals this number.
  ///
  /// If [roundTo] is provided, both numbers will be rounded by that number:
  /// ```dart
  /// (this * roundTo).round() / roundTo == (other * roundTo).round() / roundTo
  /// ```
  bool equals(num other, [num? roundTo]) {
    if (roundTo == null || (this is int && other is int)) return this == other;
    if (this is int) return this == other.roundTo(roundTo);
    return this.roundTo(roundTo) == other.roundTo(roundTo);
  }

  /// Returns `true` if this number matches or is within the
  /// range of any of the parts defined in [expression].
  ///
  /// [expression] accepts a string of numbers and/or ranges
  /// separated by commas.
  ///
  /// ```dart
  ///   final value = 7;
  ///   print(value.isWithin('0,2,4,6')); // false
  ///   print(value.isWithin('1,2,6-8,10')); // true
  ///   print(value.isWithin('7,10,12-15')); // true
  /// ```
  ///
  /// Throws an [InvalidExpressionError] if [expression] isn't valid.
  bool isWithin(String expression) {
    final parts = expression.split(',');
    for (var part in parts) {
      if (part.contains('-')) {
        final values =
            part.split('-').map<num?>((value) => num.tryParse(value)).toList();
        if (values.length != 2 || values.any((value) => value == null)) {
          throw InvalidExpressionError(part);
        }
        if (isWithinRange(values[0]!, values[1]!)) return true;
        continue;
      }
      final value = num.tryParse(part);
      if (value == null) throw InvalidExpressionError(part);
      if (this == value) return true;
    }
    return false;
  }

  /// Returns `true` if this number is within the range of [start] to [end].
  bool isWithinRange(num start, num end) {
    if (start <= end && this >= start && this <= end) return true;
    if (start > end && this >= end && this <= start) return true;
    return false;
  }

  /// Rounds this number by [value]:
  /// ```dart
  /// (this * value).round() / value
  /// ```
  num roundTo(num value) =>
      this is double ? (this * value).round() / value : this;

  /// Rounds this number to [precision] decimal points.
  num roundToPrecision(int precision) {
    final factor = math.pow(10, precision);
    return (this * factor).round() / factor;
  }

  /// Flips the sign of this number.
  num get invert => this * -1;
}

/// Extends [double] with additional basic methods.
extension DoubleUtilities on double {
  /// Rounds this double by [value]:
  /// ```dart
  /// (this * value).round() / value
  /// ```
  double roundTo(num value) => (this * value).round() / value;

  /// Rounds this double to [precision] decimal points.
  double roundToPrecision(int precision) {
    final factor = math.pow(10, precision);
    return (this * factor).round() / factor;
  }

  /// Flips the sign of this number.
  double get invert => this * -1;
}

/// An error thrown when an invalid expression is
/// provided to the `isWithin` extension method.
class InvalidExpressionError extends UnsupportedError {
  InvalidExpressionError(String expression)
      : super('\'$expression\' is not a valid expression.');
}
