import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';
import 'package:source_gen/source_gen.dart';

Future<ClassElement> createClassElement({
  required String clazz,
  String? extra,
}) async {
  final library = await resolveSource('''
      library test;
      
      import 'dart:typed_data';
      import 'package:mapify/mapify.dart';
      
      $clazz
      ''', (resolver) async {
    return resolver
        .findLibraryByName('test')
        .then((value) => ArgumentError.checkNotNull(value))
        .then((value) => LibraryReader(value));
  });

  return library.classes.first;
}
