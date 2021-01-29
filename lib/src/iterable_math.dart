/// Extends `Iterable<double>` with additional basic methods.
extension IterableMathDouble on Iterable<double> {
  /// Returns the sum of the values in the iterable.
  double sum() => length >= 2
      ? reduce((a, b) => a + b)
      : length == 1
          ? first
          : 0.0;

  /// Returns the sum of the absolute values in the iterable.
  double absSum([bool invert = false]) {
    assert(invert != null);

    var value = length >= 2
        ? reduce((a, b) => a.abs() + b.abs())
        : length == 1
            ? first.abs()
            : 0.0;

    if (invert) value *= -1;

    return value;
  }

  /// Returns the highest value in the list.
  double get highest => reduce((value, element) {
        if (value == null || (element != null && element > value)) {
          return element;
        }

        return value;
      });

  /// Returns the lowest value in the list.
  double get lowest => reduce((value, element) {
        if (value == null || (element != null && element < value)) {
          return element;
        }

        return value;
      });
}

/// Extends `Iterable<int>` with additional basic methods.
extension IterableMathInt on Iterable<int> {
  /// Returns the sum of the values in the iterable.
  int sum() => length >= 2
      ? reduce((a, b) => a + b)
      : length == 1
          ? first
          : 0.0;

  /// Returns the sum of the absolute values in the iterable.
  int absSum([bool invert = false]) {
    assert(invert != null);

    var value = length >= 2
        ? reduce((a, b) => a.abs() + b.abs())
        : length == 1
            ? first.abs()
            : 0.0;

    if (invert) value *= -1;

    return value;
  }

  /// Returns the highest value in the list.
  int get highest => reduce((value, element) {
        if (value == null || (element != null && element > value)) {
          return element;
        }

        return value;
      });

  /// Returns the lowest value in the list.
  int get lowest => reduce((value, element) {
        if (value == null || (element != null && element < value)) {
          return element;
        }

        return value;
      });
}

/// Extends `Iterable<num>` with additional basic methods.
extension IterableMathNum on Iterable<num> {
  /// Returns the sum of the values in the iterable.
  num sum() => length >= 2
      ? reduce((a, b) => a + b)
      : length == 1
          ? first
          : 0.0;

  /// Returns the sum of the absolute values in the iterable.
  num absSum([bool invert = false]) {
    assert(invert != null);

    var value = length >= 2
        ? reduce((a, b) => a.abs() + b.abs())
        : length == 1
            ? first.abs()
            : 0.0;

    if (invert) value *= -1;

    return value;
  }

  /// Returns the highest value in the list.
  num get highest => reduce((value, element) {
        if (value == null || (element != null && element > value)) {
          return element;
        }

        return value;
      });

  /// Returns the lowest value in the list.
  num get lowest => reduce((value, element) {
        if (value == null || (element != null && element < value)) {
          return element;
        }

        return value;
      });
}
