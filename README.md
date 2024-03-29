# num_utilities

A collection of extension methods for [num]s, [int]s, and [double]s;
and iterables of [num]s, [int]s, and [double]s.

__See:__ [list_utilities](https://pub.dev/packages/list_utilities)

# Usage

```dart
import 'package:num_utilities/num_utilities.dart';
```

## Numbers

[num]s, [int]s, and [double]s were extended with the
following methods/getters:

### isPositive

[isPositive] returns `true` if the number's sign is positive.

```dart
final numA = 5;
print(numA.isPositive); // true

final numB = -5;
print(numB.isPositive); // false
```

### equals

[equals] is equivalent to the `==` operator, but has an optional parameter
to round the numbers before comparing them, by calling [roundTo] (see below.)

```dart
final numA = 5.556;
final numB = 5.557;
print(numA.equals(numB)); // false
print(numA.equals(numB, 100)); // true
```

### isWithin

[isWithin] returns `true` if the number matches or is within the range
of any of the parts defined in the provided [expression].

The provided [expression] must be a string of numbers and/or ranges
separated by commas.

```dart
final value = 7;
print(value.isWithin('0,2,4,6')); // false
print(value.isWithin('1,2,6-8,10')); // true
print(value.isWithin('0-4,7,12-15')); // true
```

### isWithinRange

[isWithinRange] returns `true` if this number is within the range of the
provided [start] and [end] values.

```dart
final value = 7;
print(value.isWithinRange(4, 8)); // true
print(value.isWithinRange(8, 4)); // true
print(value.isWithinRange(2, 6)); // false
```

### roundTo

[roundTo] rounds the number by the value: `(number * value).round() / value`

```dart
final number = 5.556;
print(number.roundTo(10)); // 5.6
```

### roundToPrecision

[roundToPrecision] rounds the number to the specified number of decimal points.

```dart
final number = 5.5567893;
print(number.roundToPrecision(3)); // 5.557
```

## Iterables

Iterables of [num]s, [int]s, and [double]s were extended
with the following methods:

### sum

The [sum] method returns the sum of all of the values in the iterable.

```dart
final list = [1, 2, 3, 4, 5];
print(list.sum()); // 15
```

### absSum

The [absSum] method returns the sum of all of the absolute values in the iterable.

[absSum] has an optional parameter to invert the returned value.

```dart
final list = [1, -2, 3, -4, 5];
print(list.absSum()); // 15
print(list.absSum(false)); // 15
print(list.absSum(true)); // -15
print(list.sum()); // 3
```

### highest

The [highest] getter returns the highest value in the iterable.

```dart
final list = [1, 2, 3, 4, 5];
print(list.highest); // 5
```

### lowest

The [lowest] getter returns the lowest value in the iterable.

```dart
final list = [1, 2, 3, 4, 5];
print(list.lowest); // 1
```

## Range

The [Range] object defines a range of numbers between specified
[min] and [max] values, and has convienence methods for generating
numbers within the range and for interpolating values within the range.

```dart
final range = Range(5, 15);
print(range.min); // 5
print(range.max); // 15
```

## span

The [span] getter returns the difference between the [min] and [max] values.

```dart
print(range.span); // 10
```

## random

The [random] method will output a number between the [min] value, inclusive,
and the [max] value, exclusive.

[random] accepts an optional [seed] value.

```dart
print(range.random());
print(range.random(seed));
```

## secureRandom

The [secureRandom] method will output a cryptographically secure number
between the [min] value, inclusive, and [max] value, exclusive.

```dart
print(range.secureRandom());
```

## interpolate

The [interpolate] method returns a [List] of numbers spanning a
defined number of [steps] between the [min] and [max] values.

```dart
print(range.interpolate(5)); // [5.0, 7.0, 9.0, 11.0, 13.0]
```

### inclusive

[interpolate]'s `inclusive` parameter can be used to include the
[max] number within the output [List].

```dart
print(range.interpolate(5, inclusive: true)); // [5.0, 7.0, 9.0, 11.0, 13.0, 15.0]
```

### randomize

[interpolate]'s `randomize` parameter can be used to apply randomness
to the output numbers, where a value of `0.0` doesn't apply any randomness
to the numbers, while a value of `1.0` will randomize the output numbers
within the entire range of the radius around each step.

```dart
print(range.interpolate(5, randomize: 1.0)); // [5.23, 6.18, 8.27, 10.27, 13.46]
```
