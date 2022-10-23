import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

enum FieldConversionStrategy {
  noInputFieldAvailable,
  direct,
  mapSingleSubType,
  mapListSubType,
}


class FieldConversionProcessor {
  FieldConversionProcessor.to(
      this._outputField, {
        FieldElement? from,
      }) {
    _outputType = _outputField.type;
    _inputType = from?.type;
  }

  late final DartType _outputType;
  late final DartType? _inputType;

  final FieldElement _outputField;

  FieldConversionStrategy getConversionStrategy() {
    if (_inputType == null) {
      return FieldConversionStrategy.noInputFieldAvailable;
    } else if (_inputType == _outputType) {
      //If the type is the same, we can directly assign the value without sub-conversion
      return FieldConversionStrategy.direct;
    } else if (_outputType.isDartCoreList) {
      //The type is a list, and we should convert it via a map
      return FieldConversionStrategy.mapListSubType;
    } else {
      //The type is not the same, so we should convert the subtype
      return FieldConversionStrategy.mapSingleSubType;
    }
  }
}