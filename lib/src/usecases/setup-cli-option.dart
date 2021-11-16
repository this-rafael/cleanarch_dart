import 'package:args/args.dart';

import '../models/config-object.model.dart';

class SetupCliOption {
  static const defaultOptions = {
    'all', // IMPLEMENT ALL
    'u', // USE  CLASSES
    'i', // IMPLEMENTS CLASSES,
    'uo', // USE ONLY CLASSES
    'exports', // GENERATE EXPORTRS
  };
  final ArgParser parser;

  const SetupCliOption({required this.parser});

  Future<ArgParser> call(Set<CommandModel> commands) async {
    _setupDefaultOptions(parser);

    for (var command in commands) {
      parser.addOption(command.command);
    }

    return parser;
  }

  static Future<ArgParser> setup({
    required ArgParser parser,
    required Set<CommandModel> commands,
  }) {
    return SetupCliOption(parser: parser).call(commands);
  }

  static void _setupDefaultOptions(ArgParser parser) {
    defaultOptions.forEach((String element) {
      parser.addOption(element);
    });
  }
}
