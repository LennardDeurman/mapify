import 'package:analyzer/dart/element/element.dart';

import '../extensions/extensions.dart';
import '../processors/field_conversion_processor.dart';


class ExtensionLineWriter {
  ExtensionLineWriter({
    required FieldElement field,
    required String className,
    required FieldConversionStrategy strategy,
  }) {
    _variableName = field.name;
    _typeName = field.type.getDisplayString(withNullability: false);
    _genericTypeName = field.type.firstGenericTypeOrNull?.getDisplayString(withNullability: false);
    _isNullable = field.type.isNullable;
    _strategy = strategy;
    _className = className;
  }

  late final bool _isNullable;
  late final String _typeName;
  late final String? _genericTypeName;
  late final String _variableName;
  late final String _className;
  late final FieldConversionStrategy _strategy;

  String addInitialFieldAssignment() {
    return "mapper.convert<$_typeName>(toFieldName: '$_variableName', type: $_className,)";
  }

  StringBuffer addVariableAssignment(StringBuffer buffer) {
    return buffer..write(' ?? $_variableName');
  }

  StringBuffer addSingularTypeConverter(StringBuffer buffer) {
    return buffer..write('to$_typeName()');
  }

  StringBuffer addOptionalOperator(StringBuffer buffer) {
    return buffer..write('?');
  }

  StringBuffer addForcedCastOperator(StringBuffer buffer) {
    return buffer..write('!');
  }

  StringBuffer addListTypeConverter(StringBuffer buffer) {
    return buffer..write('.map((e) => e.to${_genericTypeName}())');
  }

  StringBuffer writeMapListSubTypeAssignment(StringBuffer buffer) {
    addVariableAssignment(buffer);
    if (_isNullable) {
      addOptionalOperator(buffer);
    }
    addListTypeConverter(buffer);

    return buffer;
  }

  StringBuffer writeMapSingleSubTypeAssignment(StringBuffer buffer) {
    addVariableAssignment(buffer);
    if (_isNullable) {
      addOptionalOperator(buffer);
    }
    addSingularTypeConverter(buffer);

    return buffer;
  }

  StringBuffer writeNoInputFieldAvailableAssignment(StringBuffer buffer) {
    if (!_isNullable) {
      addForcedCastOperator(buffer);
    }

    return buffer;
  }

  StringBuffer writeDirectVariableAssignment(StringBuffer buffer) {
    //If there's no input field from the custom mapping we fallback on the default variable
    addVariableAssignment(buffer);

    return buffer;
  }

  String write() {
    final buffer = StringBuffer(addInitialFieldAssignment());
    if (_strategy == FieldConversionStrategy.direct) {
      writeDirectVariableAssignment(buffer);
    } else if (_strategy == FieldConversionStrategy.noInputFieldAvailable) {
      writeNoInputFieldAvailableAssignment(buffer);
    } else if (_strategy == FieldConversionStrategy.mapSingleSubType) {
      writeMapSingleSubTypeAssignment(buffer);
    } else if (_strategy == FieldConversionStrategy.mapListSubType) {
      writeMapListSubTypeAssignment(buffer);
    }

    final fieldAssignment = buffer.toString();

    return '$_variableName: $fieldAssignment,';
  }
}