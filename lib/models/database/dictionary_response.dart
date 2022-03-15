import 'package:worden/models/database/definition.dart';

class DictionaryResponse {
  final String word;
  final List<Definition> definitions;

  DictionaryResponse({
    required this.word,
    required this.definitions,
  });

  static DictionaryResponse fromMap(Map<String, dynamic> map) {
    return DictionaryResponse(
      word: map['word'],
      definitions: List.from(map['definitions'])
          .map((e) => Definition.fromMap(e))
          .toList(),
    );
  }
}
