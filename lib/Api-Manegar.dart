import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app/NewsDataResponse.dart';
import 'package:news_app/SourcesResponse.dart';
import 'package:news_app/const.dart';

class ApiManager {
  static Future<SourcesResponse> getSources(String id) async {
    Uri url = Uri.https(Constants.baseUrl, "/v2/top-headlines/sources",
        {"apiKey": Constants.apiKey, "category": id});
    Response response = await http.get(url);

    var json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);

    return sourcesResponse;
  }

  static Future<NewsDataResponse> getNewsData(
      {String? sourceId, String? query}) async {
    Uri url = Uri.https(Constants.baseUrl, "/v2/everything",
        {"apiKey": Constants.apiKey, "sources": sourceId, "q": query});
    Response response = await http.get(url);
    var json = jsonDecode(response.body);
    NewsDataResponse model = NewsDataResponse.fromJson(json);

    return model;
  }
}
