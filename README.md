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

### roundTo

[roundTo] rounds the number by the value: `(number * value).round() / value`

```dart
final number = 5.556;
print(number.roundTo(10)); // 5.6
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
