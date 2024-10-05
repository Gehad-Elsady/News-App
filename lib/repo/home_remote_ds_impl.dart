import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Models/NewsDataResponse.dart';
import 'package:news_app/Models/SourcesResponse.dart';
import 'package:news_app/Cache/cache_news.dart';
import 'package:news_app/Cache/cache_sources.dart';
import 'package:news_app/const/const.dart';
import 'package:news_app/repo/repo.dart';

class HomeRemoteDsImpl implements HomeRepo {
  @override
  Future<NewsDataResponse> getNewsData(
      {String? sourceID, String? query, int? pageSize, int? page}) async {
    Uri url = Uri.https(
      Constants.baseUrl,
      "/v2/everything",
      {
        "sources": sourceID,
        "q": query,
        "pageSize": pageSize.toString(),
        "page": page.toString()
      },
    );

    http.Response response = await http.get(url, headers: {
      "x-api-key": Constants.apiKey,
    });
    var json = jsonDecode(response.body);
    NewsDataResponse newsDataResponse = NewsDataResponse.fromJson(json);
    await CacheNews.saveNews(newsDataResponse);

    return newsDataResponse;
  }

  @override
  Future<SourcesResponse> getSources(String id) async {
    Uri url = Uri.https("newsapi.org", "/v2/top-headlines/sources",
        {"apiKey": Constants.apiKey, "category": id});
    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    await CacheSources.saveSources(sourcesResponse);
    return sourcesResponse;
  }
}
