class Api {
  static const String baseURL = "https://wordsapiv1.p.rapidapi.com/words/";

  static String getDefinitionUrl(String word) {
    return baseURL + word + "/definitions";
  }

  static String getSynonymsUrl(String word) {
    return baseURL + word + "/synonyms";
  }

  static String getAntonymsUrl(String word) {
    return baseURL + word + "/antonyms";
  }

  static String getExamplesUrl(String word) {
    return baseURL + word + "/examples";
  }
}
