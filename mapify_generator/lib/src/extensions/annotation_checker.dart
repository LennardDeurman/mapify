import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:source_gen/source_gen.dart';

extension AnnotationChecker on Element {
  /// Checks if there is an annotation on this element
  bool hasAnnotation(final Type type) {
    return TypeChecker.fromRuntime(type).hasAnnotationOfExact(this);
  }

  /// Returns the first annotation object found of [type]
  /// or `null` if annotation of [type] not found
  DartObject? getAnnotation(final Type type) {
    return TypeChecker.fromRuntime(type).firstAnnotationOfExact(this);
  }
}