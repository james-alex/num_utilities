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

/// A range of numbers between defined minimum and maximum values.
class Range<T extends num> {
  /// A range of numbers between defined minimum and maximum values.
  const Range(this.min, this.max) : assert(min < max);

  /// The minimum number in the range.
  final T min;

  /// The maximum number in the range.
  final T max;

  /// The span this range covers. `max - min`.
  T get span => (max - min) as T;

  /// The value at the center of the range.
  double get center => min + (span / 2);

  /// Generates a random number between [min],
  /// inclusive, and [max], exclusive.
  T random([int? seed]) => _random(math.Random(seed));

  /// Generates a cryptographically secure random number
  /// between [min], inclusive, and [max], exclusive.
  T secureRandom() => _random(math.Random.secure());

  T _random(math.Random random) => min is double || max is double
      ? (random.nextDouble() * span + min) as T
      : (random.nextInt(span as int) + min) as T;

  /// Returns the value within the range at the defined [delta].
  double map(double delta) => (span * delta) + min;

  /// Returns a list of numbers spanning a defined number of
  /// [steps] between the [min] and [max] values.
  ///
  /// If [inclusive] is `true`, the [max] value will be included in the
  /// returned list, and the length of the list will be `steps + 1`.
  ///
  /// [randomize] can be used to apply randomness to the output numbers,
  /// where a value of `0.0` doesn't apply any randomness to the numbers,
  /// while a value of `1.0` will randomize the output numbers within the
  /// entire range of the radius around each step.
  List<double> interpolate(
    int steps, {
    bool inclusive = false,
    double randomize = 0.0,
    int? seed,
  }) {
    assert(steps > 0);
    assert(randomize >= 0.0 && randomize <= 1.0);
    math.Random? random;
    final offset = inclusive ? 1 : 0;
    final slice = span / steps;
    final radius = slice / 2;
    final list = List<double>.generate(steps - offset, (index) {
      var randomness = 0.0;
      if (randomize > 0.0) {
        random ??= math.Random(seed);
        randomness = radius - (random!.nextDouble() * slice);
        if (index == 0 && randomness.isNegative) randomness *= -1;
      }
      return ((index + offset) * slice) + min + randomness;
    });
    if (inclusive) {
      if (randomize == 0.0) {
        list.insert(0, min.toDouble());
        list.add(max.toDouble());
      } else {
        random ??= math.Random(seed);
        list.insert(0, (slice / 2) * random!.nextDouble());
        list.add(max - (slice / 2) * random!.nextDouble());
      }
    }
    return list;
  }

  @override
  operator ==(Object other) =>
      other is Range && min == other.min && max == other.max;

  @override
  int get hashCode => min.hashCode ^ max.hashCode;
}

/// An error thrown when an invalid expression is
/// provided to the `isWithin` extension method.
class InvalidExpressionError extends UnsupportedError {
  InvalidExpressionError(String expression)
      : super('\'$expression\' is not a valid expression.');
}
