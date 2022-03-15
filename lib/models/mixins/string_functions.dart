mixin StringFunctionsMixin {
  String capitalizeFirstCharacter(String word) {
    return word.replaceRange(0, 1, word.substring(0, 1).toUpperCase());
  }
}
