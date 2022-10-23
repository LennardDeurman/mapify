import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

extension DartTypeExtension on DartType {
  /// Whether this [DartType] is nullable
  bool get isNullable {
    switch (nullabilitySuffix) {
      case NullabilitySuffix.question:
      case NullabilitySuffix.star: // support legacy code without non-nullables
        return true;
      case NullabilitySuffix.none:
        return false;
    }
  }

  /// Returns the genericTypes of this [DartType] as list
  Iterable<DartType> get genericTypes {
    final obj = this;
    if (obj is ParameterizedType) {
      return obj.typeArguments;
    }
    return [];
  }

  /// Returns the first one derived from the genericTypes
  DartType? get firstGenericTypeOrNull {
    if (genericTypes.isNotEmpty) return genericTypes.first;
    return null;
  }
}