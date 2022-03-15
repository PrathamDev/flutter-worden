class Api {
  static const String baseURL = "https://wordsapiv1.p.rapidapi.com/words/";

  static String getDefinitionUrl(String word) {
    return baseURL + word + "/definitions";
  }
}
