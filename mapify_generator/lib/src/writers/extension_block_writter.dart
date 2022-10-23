import 'package:analyzer/dart/element/element.dart';

import '../processors/processors.dart';
import '../writers/extension_line_writer.dart';

class ExtensionBlockWriter {
  ExtensionBlockWriter({
    required String outputClassName,
    required String mapperClassName,
    required List<FieldElement> fields,
    required ClassElement inputTypeClassElement,
  })  : _outputClassName = outputClassName,
        _mapperClassName = mapperClassName,
        _fields = fields,
        _inputTypeClassElement = inputTypeClassElement;

  final String _outputClassName;
  final String _mapperClassName;
  final List<FieldElement> _fields;
  final ClassElement _inputTypeClassElement;

  StringBuffer addExtensionContentLines(StringBuffer buffer) {
    for (final field in _fields) {
      final fieldConversionProcessor = FieldConversionProcessor.to(
        field,
        from: _inputTypeClassElement.getField(field.name),
      );

      final extensionLineWriter = ExtensionLineWriter(
        field: field,
        className: _outputClassName,
        strategy: fieldConversionProcessor.getConversionStrategy(),
      );

      buffer.writeln(extensionLineWriter.write());
    }

    return buffer;
  }

  String write() {
    final outputBuffer = StringBuffer();

    outputBuffer.writeln('$_outputClassName to$_outputClassName() {');
    outputBuffer.writeln('final mapper = $_mapperClassName(this);');
    outputBuffer.writeln('return $_outputClassName(');
    addExtensionContentLines(outputBuffer);
    outputBuffer.writeln(');');
    outputBuffer.writeln('}');

    return outputBuffer.toString();
  }
}