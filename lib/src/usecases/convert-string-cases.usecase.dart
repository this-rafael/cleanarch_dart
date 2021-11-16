import 'package:recase/recase.dart';

class ConvertStringCase {
  static String toCamelCase(String str) {
    return ReCase(str).camelCase;
  }

  static String toKebabCase(String str) {
    return ReCase(str).paramCase;
  }
}
