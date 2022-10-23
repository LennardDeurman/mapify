import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build_test/build_test.dart';
import 'package:source_gen/source_gen.dart';


Future<DartType> getDartType(final dynamic value) async {
  return getDartTypeFromDeclaration('final value = $value');
}

Future<DartType> getDartTypeFromString(final String value) {
  return getDartType(value);
}

Future<DartType> getDartTypeFromDeclaration(final String declaration) async {
  final source = '''
  library test;
  import 'dart:typed_data';
  
  $declaration;
  ''';
  return resolveSource(source, (item) async {
    final libraryReader =
    LibraryReader((await item.findLibraryByName('test'))!);
    return (libraryReader.allElements.elementAt(1) as PropertyAccessorElement)
        .type
        .returnType;
  });
}

