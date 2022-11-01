import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:mapify/mapify.dart';
import 'package:source_gen/source_gen.dart';

import 'writers/writers.dart';
import 'processors/processors.dart';

class MapifyGenerator extends GeneratorForAnnotation<GenerateMapping> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw Exception('MapifyGenerator was defined on a none-class element');
    }

    //The name of the mapper extension derived from the managing class f.e. AccountMapper
    final mapperClassName = element.displayName;
    final processor = MapifyMainElementProcessor(element);
    final inputClassName = processor.inputClassName;

    return ExtensionWriter(
      mapperClassName: mapperClassName,
      inputClassName: inputClassName,
      inputTypeClassElement: processor.inputTypeClassElement,
      outputTypeClassElements: processor.outputTypeClassElements,
    ).write();
  }
}
