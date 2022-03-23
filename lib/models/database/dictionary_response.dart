import 'package:worden/models/database/definition.dart';
import 'package:worden/models/database/word.dart';

class DictionaryResponse {
  final Word word;
  final List<Definition> definitions;
  final List<String> synonyms;
  final List<String> antonyms;
  final List<String> examples;

  DictionaryResponse({
    required this.word,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
    required this.examples,
  });

  static DictionaryResponse fromMap(String word, Map<String, dynamic> map) {
    return DictionaryResponse(
      word: Word(word),
      definitions: List.from(map['definitions'])
          .map((e) => Definition.fromMap(e))
          .toList(),
      synonyms: List<String>.from(map['synonyms']),
      antonyms: List<String>.from(map['antonyms']),
      examples: List<String>.from(map['examples']),
    );
  }
}
