import 'dart:io';

import 'package:path/path.dart' as path;

import 'models/config-object.model.dart';
import 'usecases/generate-class.dart';
import 'usecases/generate-user-based-specific-schema.dart';
import 'usecases/get-selected-schemas.dart';
import 'usecases/parse-cli-input.dart';
import 'usecases/read-json-and-convert.dart';

void main(List<String> args) async {
  final executionLocal = path.normalize(Directory.current.absolute.path);
  final readJsonAndConfigure = ReadJsonAndConvert<ConfigObjectModel>(
    path: executionLocal,
    fileName: 'cleanarch-cli.config.json',
    converter: CONVERTER_JSON_TO_CONFIG_OBJECT,
  );

  final configModel = await readJsonAndConfigure.call();

  final schemas = configModel.schemas;
  final commands = configModel.commands;

  final opts = await ParseCliInput.parse(args);

  final selectedShemaData = GetSelectedSchema(
          keys: commands.map((e) => e.sufix).toSet(), schemas: schemas)
      .call();

  if (opts['all'] != null) {
    final classesBaseName = opts['all'] as Set<String>;

    for (var classBaseName in classesBaseName) {
      for (var schema in schemas) {
        final result = await GenerateBasedSpecificSchema(
          key: schema.sufix,
          opts: opts,
          schema: schema,
          executionLocal: executionLocal,
          generateClassUtil: GenerateClass(''),
          classBaseName: classBaseName,
          isAbstract: schema.abstractClass,
        ).call();

        print(['SUCESS', result.folderName, result.fileName]);
      }
    }
  } else {
    final keys = opts.keys.toSet();

    
    final elementKey = commands.firstWhere(
      (command) =>
          command.sufix.toUpperCase() == selectedShemaData.key.toUpperCase(),
    );

  
    final classesBaseName = (opts[elementKey.command]) as Set;
    for (var classBaseName in classesBaseName) {
      final result = await GenerateBasedSpecificSchema(
        key: selectedShemaData.schema.sufix,
        opts: opts,
        schema: selectedShemaData.schema,
        executionLocal: executionLocal,
        generateClassUtil: GenerateClass(''),
        classBaseName: classBaseName,
        isAbstract: selectedShemaData.schema.abstractClass,
      ).call();

      print(['SUCESS', result.folderName, result.fileName]);
    }
  }
}
