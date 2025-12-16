import 'dart:convert';
import 'package:http/http.dart';
import 'package:newsapp/data/models/articles_response_dm.dart';
import '../models/SourcesResponse.dart';

abstract class ApiManager {
  static const String _apiKey = "ebbd81f2f82b4730b191f24278b53bb3";
  static const String _baseUrl = "newsapi.org";

  static Future<SourcesResponseDM> getSources(String categoryId) async {
    Uri url = Uri.https(_baseUrl, "/v2/top-headlines/sources", {
      "apiKey": _apiKey,
      "category": categoryId,
    });
    Response response = await get(url);
    Map json = jsonDecode(response.body);

    SourcesResponseDM sourcesResponse = SourcesResponseDM.fromJson(json);

    if (sourcesResponse.message != null) {
      throw Exception(sourcesResponse.message);
    }
    return sourcesResponse;
  }

  static Future<ArticlesResponseDm> getArticles(String sourceId) async {
    // Fixed: Use top-headlines endpoint and pass sourceId
    Uri url = Uri.https(_baseUrl, "/v2/top-headlines", {
      "apiKey": _apiKey,
      "sources": sourceId,
    });

    Response response = await get(url);
    Map json = jsonDecode(response.body);
    ArticlesResponseDm articlesResponseDm = ArticlesResponseDm.fromJson(json);
    if (articlesResponseDm.message != null) {
      throw Exception(articlesResponseDm.message ?? "Failed to load articles");
    }
    return articlesResponseDm;
  }
}
