import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/mapify_generator.dart';

Builder mapify(BuilderOptions options) => SharedPartBuilder(
      [MapifyGenerator()],
      'mapify_generator',
    );