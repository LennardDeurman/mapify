import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';
import 'package:source_gen/source_gen.dart';

Future<FieldElement> generateFieldElement(final String field) async {
  final library = await resolveSource('''
      library test;
      
      class Foo {
        $field
      }
      
      class CustomObject {}
      
      class CustomObjectEntity {}
      
      ''', (resolver) async {
    return resolver
        .findLibraryByName('test')
        .then((value) => ArgumentError.checkNotNull(value))
        .then((value) => LibraryReader(value));
  });

  return library.classes.first.fields.first;
}