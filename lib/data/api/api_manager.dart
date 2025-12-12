import 'dart:convert';
import 'package:http/http.dart';
import '../models/SourcesResponse.dart';

abstract class ApiManager {
  static Future<List<Source>> getSources() async{
    Uri url =Uri.parse("https://newsapi.org/v2/top-headlines/sources?apiKey=60abc2315ebf47508c0ef3c97a0e83a4");
    Response response=await get(url);
    Map json = jsonDecode(response.body);

    SourcesResponse sourcesResponse=SourcesResponse.fromJson(json);

    if (response.statusCode>=200&&response.statusCode<300&&sourcesResponse.sources?.isNotEmpty==true){
      return sourcesResponse.sources!;
    }
    print("1111111111111111");
    throw Exception(sourcesResponse.message);
  }

  static getArticles(){

  }
}