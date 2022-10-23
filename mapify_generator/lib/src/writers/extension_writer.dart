import 'package:analyzer/dart/element/element.dart';

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

  String write() {
    // start the extension
    final outputBuffer = StringBuffer();
    outputBuffer.writeln('extension ${_mapperClassName}Extension on $_inputClassName{');

    for (final outputTypeClassElement in _outputTypeClassElements) {
      final outputClassName = outputTypeClassElement.displayName;
      final fields = outputTypeClassElement.fields;

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

    return outputBuffer.toString();
  }
}
