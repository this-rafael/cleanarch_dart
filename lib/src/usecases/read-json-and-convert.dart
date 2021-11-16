import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../models/config-object.model.dart';
import 'package:path/path.dart' as path_module;

typedef ConvertJsonToTypes<T> = FutureOr<T> Function(Map<String, dynamic>);

class ReadJsonAndConvert<T> {
  final String path;
  final String fileName;
  final ConvertJsonToTypes<T> converter;

  const ReadJsonAndConvert({
    required this.path,
    required this.fileName,
    required this.converter,
  });


  FutureOr<T> call() async {
    final Map<String, dynamic> json = jsonDecode(File(path_module.normalize('$path/$fileName')).readAsStringSync());
    return converter(json);
  }

}


final ConvertJsonToTypes<ConfigObjectModel> CONVERTER_JSON_TO_CONFIG_OBJECT = (Map<String, dynamic> data) async {
  return ConfigObjectModel.fromJson(data);
};
