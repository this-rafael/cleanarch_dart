class GetNamesfromString {
  final String value;

  const GetNamesfromString(this.value);

  Future<List<String>> call({
    String? pattern
  }) async {

    return value.split(pattern ?? ' ');
  }
}
