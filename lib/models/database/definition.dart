class Definition {
  final String definition;
  final String partsOfSpeech;
  Definition({
    required this.definition,
    required this.partsOfSpeech,
  });

  static Definition fromMap(Map<String, dynamic> map) {
    return Definition(
        definition: map['definition'] ?? '',
        partsOfSpeech: map['partOfSpeech'] ?? '');
  }
}
