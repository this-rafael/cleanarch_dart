class ConfigObjectModel {
  final Set<CommandModel> commands;
  final Set<Schema> schemas;

  ConfigObjectModel({
    required this.commands,
    required this.schemas,
  });

  factory ConfigObjectModel.fromJson(Map<String, dynamic> data) {
    return ConfigObjectModel(
      commands: (data['commands'] as List)
          .map((json) => CommandModel.fromJson(json))
          .toSet(),
      schemas:
          (data['schema'] as List).map((json) => Schema.fromJson(json)).toSet(),
    );
  }
}

class CommandModel {
  final String command;
  final String sufix;
  final String? comment;

  const CommandModel({
    required this.command,
    required this.sufix,
    this.comment,
  });

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
      sufix: json['sufix'],
      command: json['command'],
      comment: json['comment'],
    );
  }
}

class Schema {
  final String sufix;
  final String terminologySufix;
  final String languageSufix;
  final String defaultImplementsSufix;
  final String defaultDependenciesSufix;
  final String folder;
  final bool abstractClass;
  final Set<String> useDecorators;
  final Set<String> defaultMethods;

  const Schema({
    required this.sufix,
    required this.terminologySufix,
    required this.languageSufix,
    required this.defaultImplementsSufix,
    required this.defaultDependenciesSufix,
    required this.folder,
    required this.abstractClass,
    required this.useDecorators,
    required this.defaultMethods,
  });

  factory Schema.fromJson(Map<String, dynamic> data) {
    return Schema(
        sufix: data['sufix'],
        terminologySufix: data['extensionSufix'],
        languageSufix: data['languageSufix'],
        defaultImplementsSufix: data['defaultImplementsSuffix'],
        defaultDependenciesSufix: data['defaultDependenciesSuffix'],
        folder: data['folder'],
        abstractClass: data['abstract'],
        useDecorators:
            (data['useDecorators'] as List).map((e) => e as String).toSet(),
        defaultMethods:
            (data['defaultMethods'] as List).map((e) => e as String).toSet());
  }

  @override
  String toString() {
    return {
      'sufix': sufix,
      // 'terminologySufix': terminologySufix,
      // 'languageSufix': languageSufix,
      // 'defaultImplementsSufix': defaultImplementsSufix,
      // 'defaultDependenciesSufix': defaultDependenciesSufix,
      // 'folder': folder,
      // 'abstractClass': abstractClass,
      // 'useDecorators': useDecorators,
      // 'defaultMethods': defaultMethods,
    }.toString();
  }
}
