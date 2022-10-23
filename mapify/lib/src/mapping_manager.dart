/// The class that's used for creating the extensions upon
abstract class MappingManager<InputType> {
  /// The mapping manager takes the original object as input
  const MappingManager(this.input);

  final InputType input;
  
  /// When mapping the object the created extension will first invoke the
  /// convert method to see if there's a custom conversion defined
  /// [toFieldName] represents the field name of which the object will be mapped
  /// By default returns null and uses the outputType.fieldName
  ResultType? convert<ResultType>({
    required String toFieldName,
    required Type type,
  }) => null;
}
