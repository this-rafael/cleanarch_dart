import 'convert-string-cases.usecase.dart';

class GenerateClass {
  String data;

  GenerateClass(
    this.data,
  );

  GenerateClass insertDecoratos(List<String> decorators) {
    final lenght = decorators.length;

    for (var i = 1; i < lenght; i++) {
      final decorator = decorators[i];
      data += decorator;

      if (i < lenght - 1) {
        data += '\n';
      }
    }
    return this;
  }

  GenerateClass implementsSomething(Set<String> interfaces) {
    final message = ' implements ' +
        interfaces.reduce(
          (acc, current) {
            return '$acc, $current';
          },
        );
    data += message;
    return this;
  }

  GenerateClass breakLine() {
    data += '\n';
    return this;
  }

  GenerateClass openBrackets() {
    data += ' {';
    return this;
  }

  GenerateClass closeBrackets() {
    data += '}';
    return this;
  }

  GenerateClass declareClass(bool isAbstract, String name) {
    if (isAbstract) {
      data += 'abstract class $name';
    } else {
      data += 'class $name';
    }

    return this;
  }

  GenerateClass generateConstructorAndUseSomething({
    required String className,
    required Set<String> classes,
  }) {
    final classesList = classes.toList();

    var constructor = '  const $className({\n';
    var fields = '';

    final length = classes.length;

    for (var i = 0; i < length; i++) {
      final element = classesList[i];

      fields += '  final $element ${ConvertStringCase.toCamelCase(element)};\n';
      constructor += '    required this.${ConvertStringCase.toCamelCase(element)},\n';
    }

    constructor += '  });';

    data += fields;
    data += constructor;

    return this;
  }

  String generate({
    required bool isAbstract,
    required Set<String> decorators,
    required String classBaseName,
    Set<String>? usesClasses,
    Set<String>? implementsClasses,
    required Set<String> imports,
    required Set<String> defaultMethods,
  }) {


    insertDecoratos(decorators.toList())
        .declareClass(isAbstract, classBaseName);

    if (implementsClasses != null && implementsClasses.isNotEmpty) {
      implementsSomething(implementsClasses).openBrackets().breakLine();
    } else {
      openBrackets().breakLine();
    }

    if (usesClasses != null && usesClasses.isNotEmpty) {
      generateConstructorAndUseSomething(className: classBaseName, classes: usesClasses);
    }

    breakLine();
    
    if(defaultMethods != null && defaultMethods.isNotEmpty) {
      data += defaultMethods.map((m) => '  ' + '$m').join('\n') + '\n';
    }


    breakLine().closeBrackets();
    return data;
  }
}
