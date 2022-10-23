import 'package:mapify_generator/src/extensions/iterable_extension.dart';
import 'package:test/test.dart';

void main() {
  group('mapNotNull', () {
    test('applies transformation yielding only non-null values', () {
      final actual = [
        _NullableBox(0),
        _NullableBox(null),
        _NullableBox(1),
      ].mapNotNull((box) => box.number);

      expect(actual, equals([0, 1]));
    });
  });
}

class _NullableBox {
  final int? number;

  _NullableBox(this.number);
}
