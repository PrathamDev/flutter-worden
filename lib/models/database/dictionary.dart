import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worden/models/database/api.dart';
import 'package:worden/models/database/dictionary_response.dart';
import 'package:http/http.dart';
import 'package:worden/models/database/word.dart';
import 'package:worden/models/exception/api_exception.dart';

class Dictionary {
  static Future<DictionaryResponse> search(Word word) async {
    DictionaryResponse response;

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await word.firebaseSnapshot();

    if (snapshot.exists) {
      response = DictionaryResponse.fromMap(snapshot.id, snapshot.data()!);
    } else {
      Map<String, dynamic> result = {};
      var definitions = await retrieveDefinitionFromApi(word);
      var synonyms = await retrieveSynonymsFromApi(word);
      var antonyms = await retrieveAntonymsFromApi(word);
      var examples = await retrieveExamplesFromApi(word);

      result.addAll({
        "definitions": definitions["definitions"],
        "synonyms": synonyms["synonyms"],
        "antonyms": antonyms['antonyms'],
        "examples": examples['examples'],
      });

      word.addInFirebase(result);

      response = DictionaryResponse.fromMap(word.value, result);
    }

    return response;
  }

  static Future<Map<String, dynamic>> retrieveDefinitionFromApi(
      Word word) async {
    String url = Api.getDefinitionUrl(word.value);
    Uri uri = Uri.parse(url);
    Response response = await get(
      uri,
      headers: {
        'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
        'x-rapidapi-key': '89e3b19de5mshe9a358475848012p113b65jsn9a953ecd2efe'
      },
    );
    Map<String, dynamic> result = jsonDecode(response.body);
    if (result["success"] == false) {
      throw ApiException(
          code: ApiExceptionCode.wordNotFound, message: result['message']);
    }

    return result;
  }

  static Future<Map<String, dynamic>> retrieveSynonymsFromApi(Word word) async {
    String url = Api.getSynonymsUrl(word.value);
    Uri uri = Uri.parse(url);
    Response response = await get(
      uri,
      headers: {
        'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
        'x-rapidapi-key': '89e3b19de5mshe9a358475848012p113b65jsn9a953ecd2efe'
      },
    );
    Map<String, dynamic> result = jsonDecode(response.body);
    if (result["success"] == false) {
      throw ApiException(
          code: ApiExceptionCode.wordNotFound, message: result['message']);
    }
    return result;
  }

  static Future<Map<String, dynamic>> retrieveAntonymsFromApi(Word word) async {
    String url = Api.getAntonymsUrl(word.value);
    Uri uri = Uri.parse(url);
    Response response = await get(
      uri,
      headers: {
        'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
        'x-rapidapi-key': '89e3b19de5mshe9a358475848012p113b65jsn9a953ecd2efe'
      },
    );
    Map<String, dynamic> result = jsonDecode(response.body);
    if (result["success"] == false) {
      throw ApiException(
          code: ApiExceptionCode.wordNotFound, message: result['message']);
    }
    return result;
  }

  static Future<Map<String, dynamic>> retrieveExamplesFromApi(Word word) async {
    String url = Api.getExamplesUrl(word.value);
    Uri uri = Uri.parse(url);
    Response response = await get(
      uri,
      headers: {
        'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
        'x-rapidapi-key': '89e3b19de5mshe9a358475848012p113b65jsn9a953ecd2efe'
      },
    );
    Map<String, dynamic> result = jsonDecode(response.body);
    if (result["success"] == false) {
      throw ApiException(
          code: ApiExceptionCode.wordNotFound, message: result['message']);
    }
    return result;
  }
}
