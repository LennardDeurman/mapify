import 'package:analyzer/dart/element/element.dart';
import 'package:mapify/mapify.dart';

import '../extensions/extensions.dart';

class MapifyMainElementProcessor {
  MapifyMainElementProcessor(ClassElement classElement) {
    //The annotation object for the classElement GenerateMapping
    final annotation = classElement.getAnnotation(GenerateMapping);

    if (annotation == null) {
      throw Exception('Not a valid GenerateMapping class element, lacks annotation');
    }

    final inputType = annotation.getField(GenerateMappingFields.inputType);
    final outputType = annotation.getField(GenerateMappingFields.outputType);

    final inputTypeClassElement = inputType?.toTypeValue()?.element2;
    final outputTypeClassElements = outputType
        ?.toListValue()
        ?.mapNotNull((object) => object.toTypeValue()?.element2)
        .whereType<ClassElement>()
        .toList();

    if (inputTypeClassElement == null || inputTypeClassElement is! ClassElement || outputTypeClassElements == null) {
      throw Exception('Mapping not correctly defined with fields inputType and outputType');
    }

    this.inputTypeClassElement = inputTypeClassElement;
    this.outputTypeClassElements = outputTypeClassElements;
  }

  late final ClassElement inputTypeClassElement;
  late final List<ClassElement> outputTypeClassElements;

  String get inputClassName => inputTypeClassElement.displayName;
}
