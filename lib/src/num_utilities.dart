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
