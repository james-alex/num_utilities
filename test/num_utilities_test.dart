import 'dart:math';
import 'package:collection/collection.dart' show ListEquality;
import 'package:num_utilities/num_utilities.dart';
import 'package:test/test.dart';

void main() {
  group('NumUtilities', () {
    test('equals', () {
      final numA = 5.556;
      final numB = 5.557;
      expect(numA.equals(numB), equals(false));
      expect(numA.equals(numB, 100), equals(true));
    });

    test('isWithin', () {
      final number = 5.556;
      expect(number.isWithin('5'), equals(false));
      expect(number.isWithin('5.556'), equals(true));
      expect(number.isWithin('5-6'), equals(true));
      expect(number.isWithin('6-5'), equals(true));
      expect(number.isWithin('4,5,6'), equals(false));
      expect(number.isWithin('4, 5, 6'), equals(false));
      expect(number.isWithin('4.556,5.556,6.556'), equals(true));
      expect(number.isWithin('4.556, 5.556, 6.556'), equals(true));
      expect(number.isWithin('2-4,5.556,6-8'), equals(true));
      expect(number.isWithin('0-2,8-10,12-15'), equals(false));
      expect(number.isWithin('0-2,4-8,10-12'), equals(true));
      final integer = 5;
      expect(integer.isWithin('5'), equals(true));
      expect(integer.isWithin('5.556'), equals(false));
      expect(integer.isWithin('5-6'), equals(true));
      expect(integer.isWithin('6-5'), equals(true));
      expect(integer.isWithin('4,5,6'), equals(true));
      expect(integer.isWithin('4, 5, 6'), equals(true));
      expect(integer.isWithin('4.556,5.556,6.556'), equals(false));
      expect(integer.isWithin('4.556, 5.556, 6.556'), equals(false));
      expect(integer.isWithin('2-4,5.556,6-8'), equals(false));
      expect(integer.isWithin('0-2,8-10,12-15'), equals(false));
      expect(integer.isWithin('0-2,4-8,10-12'), equals(true));
    });

    test('isWithinRange', () {
      final number = 5.556;
      expect(number.isWithinRange(0, 10), equals(true));
      expect(number.isWithinRange(10, 0), equals(true));
      expect(number.isWithinRange(0, -10), equals(false));
      expect(number.isWithinRange(10, 20), equals(false));
      final integer = 5;
      expect(integer.isWithinRange(0, 10), equals(true));
      expect(integer.isWithinRange(10, 0), equals(true));
      expect(integer.isWithinRange(0, -10), equals(false));
      expect(integer.isWithinRange(10, 20), equals(false));
    });

    test('roundTo', () {
      final number = 5.556;
      expect(number.roundTo(10), equals(5.6));
      final integer = 10;
      expect(integer.roundTo(10), equals(10));
    });

    test('roundToPrecision', () {
      final number = 5.5567893;
      expect(number.roundToPrecision(3), equals(5.557));
      final integer = 10;
      expect(integer.roundToPrecision(3), equals(10));
    });

    test('invert', () {
      final number = 5.556;
      expect(number.invert, equals(-5.556));
      final integer = 10;
      expect(integer.invert, equals(-10));
    });
  });

  group('Range', () {
    test('span', () {
      expect(Range(32, 96).span, equals(64));
      expect(Range(2.5, 7.5).span, equals(5.0));
    });

    test('random', () {
      final random = Random();
      for (var i = 0; i < 10000; i++) {
        late num randomValue;
        late num min;
        late num max;
        switch (i % 2) {
          case 0:
            min = random.nextInt(100);
            max = min + random.nextInt(100) + 1;
            randomValue = Range(min as int, max as int)
                .random(DateTime.now().millisecondsSinceEpoch);
            break;
          case 1:
            min = random.nextDouble() * 100;
            max = min + (random.nextDouble() * 100) + 1;
            randomValue =
                Range(min, max).random(DateTime.now().millisecondsSinceEpoch);
            break;
        }
        expect(randomValue >= min, equals(true));
        expect(randomValue < max, equals(true));
      }
    });

    test('secureRandom', () {
      final random = Random();
      for (var i = 0; i < 10000; i++) {
        late num randomValue;
        late num min;
        late num max;
        switch (i % 2) {
          case 0:
            min = random.nextInt(100);
            max = min + random.nextInt(100) + 1;
            randomValue = Range(min as int, max as int).secureRandom();
            break;
          case 1:
            min = random.nextDouble() * 100;
            max = min + (random.nextDouble() * 100) + 1;
            randomValue = Range(min, max).secureRandom();
            break;
        }
        expect(randomValue >= min, equals(true));
        expect(randomValue < max, equals(true));
      }
    });

    group('interpolate', () {
      test('default', () {
        final range = Range(0, 10).interpolate(10);
        final expectedRange = List<int>.generate(10, (index) => index);
        expect(ListEquality().equals(range, expectedRange), equals(true));
      });

      test('inclusive', () {
        final range = Range(0, 10).interpolate(10, inclusive: true);
        final expectedRange = List<int>.generate(11, (index) => index);
        expect(ListEquality().equals(range, expectedRange), equals(true));
      });

      test('randomized', () {
        final range = Range(0, 10).interpolate(10, randomize: 1.0);
        for (var i = 0; i < 10; i++) {
          expect(range[i] >= i - 0.5 && range[i] < i + 0.5, equals(true));
        }
      });

      test('inclusive & randomized', () {
        final range =
            Range(0, 10).interpolate(10, inclusive: true, randomize: 1.0);
        for (var i = 0; i < 11; i++) {
          expect(range[i] >= i - 0.5 && range[i] < i + 0.5, equals(true));
        }
      });
    });

    test('==', () {
      expect(Range(0, 2) == Range(0, 2), equals(true));
    });
  });

  group('IterableMath', () {
    group('int', () {
      test('sum', () {
        final list = <int>[1, 2, 3, 4, 5];
        expect(list.sum(), equals(15));
      });

      test('absSum', () {
        final list = <int>[1, -2, 3, -4, 5];
        expect(list.absSum(), equals(15));
        expect(list.absSum(true), equals(-15));
      });

      test('highest', () {
        final list = <int>[1, 2, 3, 4, 5];
        expect(list.highest, equals(5));
      });

      test('lowest', () {
        final list = <int>[1, 2, 3, 4, 5];
        expect(list.lowest, equals(1));
      });
    });

    group('double', () {
      test('sum', () {
        final list = <double>[1.0, 2.0, 3.0, 4.0, 5.0];
        expect(list.sum(), equals(15.0));
      });

      test('absSum', () {
        final list = <double>[1.0, -2.0, 3.0, -4.0, 5.0];
        expect(list.absSum(), equals(15.0));
        expect(list.absSum(true), equals(-15.0));
      });

      test('highest', () {
        final list = <double>[1.0, 2.0, 3.0, 4.0, 5.0];
        expect(list.highest, equals(5.0));
      });

      test('lowest', () {
        final list = <double>[1.0, 2.0, 3.0, 4.0, 5.0];
        expect(list.lowest, equals(1.0));
      });
    });

    group('num', () {
      test('sum', () {
        final list = <num>[1, 2, 3, 4, 5];
        expect(list.sum(), equals(15));
      });

      test('absSum', () {
        final list = <num>[1, -2, 3, -4, 5];
        expect(list.absSum(), equals(15));
        expect(list.absSum(true), equals(-15));
      });

      test('highest', () {
        final list = <num>[1, 2, 3, 4, 5];
        expect(list.highest, equals(5));
      });

      test('lowest', () {
        final list = <num>[1, 2, 3, 4, 5];
        expect(list.lowest, equals(1));
      });

      test('isIncremental', () {
        expect(<num>[1, 2, 3, 4, 5].isIncremental, equals(true));
        expect(<num>[5, 4, 3, 2, 1].isIncremental, equals(false));
        expect(<num>[3, 1, 2, 5, 4].isIncremental, equals(false));
        expect(<num>[1, 1, 2, 2, 3].isIncremental, equals(true));
      });

      test('isDecremental', () {
        expect(<num>[1, 2, 3, 4, 5].isDecremental, equals(false));
        expect(<num>[5, 4, 3, 2, 1].isDecremental, equals(true));
        expect(<num>[3, 1, 2, 5, 4].isDecremental, equals(false));
        expect(<num>[3, 3, 2, 2, 1].isDecremental, equals(true));
      });
    });
  });
}
