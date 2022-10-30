import 'dart:io';

Future<String> readResource(String fileName) {
  return File('${Directory.current.path}/test_resources/$fileName').readAsString();
}