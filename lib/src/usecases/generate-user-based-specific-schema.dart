import 'dart:io';
import 'package:path/path.dart' as path;

import '../models/config-object.model.dart';
import 'convert-string-cases.usecase.dart';
import 'generate-class.dart';

class GenerateBasedSpecificSchema {
  final Schema schema;
  final String executionLocal;
  final GenerateClass generateClassUtil;
  final String key;
  final String classBaseName;
  final bool isAbstract;
  final Map<String, dynamic> opts;

  const GenerateBasedSpecificSchema({
    required this.schema,
    required this.executionLocal,
    required this.generateClassUtil,
    required this.key,
    required this.classBaseName,
    required this.isAbstract,
    required this.opts,
  });

  Future<SuccessCreationFile> call() async {
    final decorators = schema.useDecorators;
    final imports = <String>[];
    final useClasses = <String>{};
    final implementsClasses = <String>{};
    

    if (opts.containsKey('uo')) {
      useClasses.addAll(opts['uo']);
    }

    final defaultDependenciesSuffix = schema.defaultDependenciesSufix;

    if (opts.containsKey('u') && defaultDependenciesSuffix.isNotEmpty) {
      useClasses.addAll((opts['u'] as List<String>)
          .map((className) => '$className$defaultDependenciesSuffix')
          .toSet());
    } else if (defaultDependenciesSuffix.isNotEmpty) {
      useClasses.add('$classBaseName$defaultDependenciesSuffix');
    }

    final defaultImplementsSuffix = schema.defaultImplementsSufix;

    if (opts.containsKey('i') && defaultImplementsSuffix.isNotEmpty) {
      implementsClasses.addAll((opts['i'] as List)
          .map((className) => '$className$defaultImplementsSuffix')
          .toSet());
    } else if (defaultImplementsSuffix.isNotEmpty) {
      implementsClasses.add('$classBaseName$defaultImplementsSuffix');
    }

    final content = generateClassUtil.generate(
      isAbstract: isAbstract,
      decorators: decorators,
      classBaseName: '$classBaseName$key',
      imports: imports.toSet(),
      defaultMethods: schema.defaultMethods,
      implementsClasses: implementsClasses,
      usesClasses: useClasses,

    );

    final fileName =
        '/${ConvertStringCase.toKebabCase(classBaseName)}${schema.terminologySufix}${schema.languageSufix}';
    final folderLocal =
        path.normalize(path.join(executionLocal, schema.folder));

    

    if (!Directory(folderLocal).existsSync()) {
      Directory(folderLocal).createSync(recursive: true);
    }

    final creationFileLocal = path.normalize('$folderLocal/$fileName');
  
    File(creationFileLocal).writeAsStringSync(content);

    return  SuccessCreationFile(fileName, folderLocal);
  }
}


class SuccessCreationFile {
  final fileName;
  final folderName;

  const SuccessCreationFile(this.fileName, this.folderName);
}