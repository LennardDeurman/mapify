/// Marks a class as a Mappable object
class GenerateMapping {
  /// Annotation class to generate a mappable object
  const GenerateMapping({
    required this.outputType,
    required this.inputType,
  });

  /// The output entities
  final List<Type> outputType;

  /// The input entitity
  final Type inputType;
}
