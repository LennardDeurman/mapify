import 'package:analyzer/dart/element/element.dart';
import 'package:dart_style/dart_style.dart';

import 'writers.dart';

class ExtensionWriter {
  ExtensionWriter({
    required String mapperClassName,
    required String inputClassName,
    required ClassElement inputTypeClassElement,
    required List<ClassElement> outputTypeClassElements,
  })  : _mapperClassName = mapperClassName,
        _inputClassName = inputClassName,
        _inputTypeClassElement = inputTypeClassElement,
        _outputTypeClassElements = outputTypeClassElements;

  final String _mapperClassName;
  final String _inputClassName;
  final ClassElement _inputTypeClassElement;
  final List<ClassElement> _outputTypeClassElements;

  final DartFormatter _dartFormatter = DartFormatter();

  List<FieldElement> getConstructorFields(ClassElement classElement) {
    final fields = <FieldElement>[];

    final constructor = classElement.constructors.first;

    constructor.parameters.forEach((parameterElement) {
      final field = classElement.getField(parameterElement.name);
      if (field != null) fields.add(field);
    });

    return fields;
  }

  String write() {
    // start the extension
    final outputBuffer = StringBuffer();
    outputBuffer.writeln('extension ${_mapperClassName}Extension on $_inputClassName{');

    for (final outputTypeClassElement in _outputTypeClassElements) {
      final outputClassName = outputTypeClassElement.displayName;
      final fields = getConstructorFields(outputTypeClassElement);

      outputBuffer.write(
        ExtensionBlockWriter(
          outputClassName: outputClassName,
          mapperClassName: _mapperClassName,
          fields: fields,
          inputTypeClassElement: _inputTypeClassElement,
        ).write(),
      );
    }

    // end the extension
    outputBuffer.writeln('}');

    return _dartFormatter.format(outputBuffer.toString());
  }
}
