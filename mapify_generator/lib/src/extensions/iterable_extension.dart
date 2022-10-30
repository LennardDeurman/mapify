extension IterableExtension<T> on Iterable<T> {
  /// Removes all the null elements from a list
  Iterable<R> mapNotNull<R>(R? Function(T element) transform) sync* {
    for (final element in this) {
      final transformed = transform(element);
      if (transformed != null) yield transformed;
    }
  }
}