class ParseCliInput {


  const ParseCliInput();

  static Future<Map<String, dynamic>> parse(dynamic data) async {
    return ParseCliInput().call(data);
  }

  Future<Map<String, dynamic>> call(List<String> data) async {
    var response = <String, Set<String>>{};
    for (var arg in data) {
      final splitedData = arg.split('=');
      response.addAll({splitedData[0]: splitedData[1].split(' ').toSet()});
    }

    
    return response;
  }
}
