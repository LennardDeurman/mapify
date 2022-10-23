/// Marks a class as a Mappable object
class GenerateMapping {
  const GenerateMapping({
    required this.outputType,
    required this.inputType,
  });

  /// The output entities
  final List<Type> outputType;

  /// The input entitity
  final Type inputType;
}