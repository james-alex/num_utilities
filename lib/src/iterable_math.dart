import 'num_utilities.dart';

/// Extends `Iterable<double>` with additional basic methods.
extension IterableMathDouble on Iterable<double> {
  /// Returns the sum of the values in the iterable.
  double sum() => cast<num?>().sum().toDouble();

  /// Returns the sum of the absolute values in the iterable.
  double absSum([bool invert = false]) => cast<num?>().absSum(invert).toDouble();

  /// Returns the highest value in the list.
  double get highest => cast<num?>().highest!.toDouble();

  /// Returns the lowest value in the list.
  double get lowest => cast<num?>().lowest!.toDouble();
}

extension IterableMathDoubleNullable on Iterable<double?> {
  /// Returns the sum of the values in the iterable.
  double sum() => cast<num?>().sum().toDouble();

  /// Returns the sum of the absolute values in the iterable.
  double absSum([bool invert = false]) =>
      cast<num?>().absSum(invert).toDouble();

  /// Returns the highest value in the list.
  double? get highest => cast<num?>().highest?.toDouble();

  /// Returns the lowest value in the list.
  double? get lowest => cast<num?>().lowest?.toDouble();
}

/// Extends `Iterable<int>` with additional basic methods.
extension IterableMathInt on Iterable<int> {
  /// Returns the sum of the values in the iterable.
  int sum() => cast<num?>().sum().toInt();

  /// Returns the sum of the absolute values in the iterable.
  int absSum([bool invert = false]) => cast<num?>().absSum(invert).toInt();

  /// Returns the highest value in the list.
  int get highest => cast<num?>().highest!.toInt();

  /// Returns the lowest value in the list.
  int get lowest => cast<num?>().lowest!.toInt();
}

/// Extends `Iterable<int>` with additional basic methods.
extension IterableMathIntNullable on Iterable<int?> {
  /// Returns the sum of the values in the iterable.
  int sum() => cast<num?>().sum().toInt();

  /// Returns the sum of the absolute values in the iterable.
  int absSum([bool invert = false]) => cast<num?>().absSum(invert).toInt();

  /// Returns the highest value in the list.
  int? get highest => cast<num?>().highest?.toInt();

  /// Returns the lowest value in the list.
  int? get lowest => cast<num?>().lowest?.toInt();
}

/// Extends `Iterable<num>` with additional basic methods.
extension IterableMathNum on Iterable<num> {
  /// Returns the sum of the values in the iterable.
  num sum() => cast<num?>().sum();

  /// Returns the sum of the absolute values in the iterable.
  num absSum([bool invert = false]) => cast<num?>().absSum(invert);

  /// Returns the highest value in the list.
  num get highest => cast<num?>().highest!;

  /// Returns the lowest value in the list.
  num get lowest => cast<num?>().lowest!;
}

/// Extends `Iterable<num>` with additional basic methods.
extension IterableMathNumNullable on Iterable<num?> {
  /// Returns the sum of the values in the iterable.
  num sum() => length >= 2
      ? reduce((a, b) => (a ?? 0.0) + (b ?? 0.0))!
      : length == 1
          ? first ?? 0.0
          : 0.0;

  /// Returns the sum of the absolute values in the iterable.
  num absSum([bool invert = false]) {
    var value = length >= 2
        ? reduce((a, b) => (a?.abs() ?? 0.0) + (b?.abs() ?? 0.0))!
        : length == 1
            ? first?.abs() ?? 0.0
            : 0.0;
    if (invert) value = value.invert;
    return value;
  }

  /// Returns the highest value in the list.
  num? get highest => reduce((value, element) {
        if (value == null || (element != null && element > value)) {
          return element;
        }
        return value;
      });

  /// Returns the lowest value in the list.
  num? get lowest => reduce((value, element) {
        if (value == null || (element != null && element < value)) {
          return element;
        }
        return value;
      });
}
