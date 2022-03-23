mixin StringFunctionsMixin {
  String capitalizeFirstCharacter(String? word) {
    if (word!.isEmpty) {
      return '';
    }
    return word.replaceRange(0, 1, word.substring(0, 1).toUpperCase());
  }
}
