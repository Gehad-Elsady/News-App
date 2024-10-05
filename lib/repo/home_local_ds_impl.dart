import 'package:news_app/Models/NewsDataResponse.dart';
import 'package:news_app/Models/SourcesResponse.dart';
import 'package:news_app/Cache/cache_news.dart';
import 'package:news_app/Cache/cache_sources.dart';
import 'package:news_app/repo/repo.dart';

class HomeLocalDsImpl implements HomeRepo {
  @override
  Future<NewsDataResponse> getNewsData(
      {String? sourceID, String? query, int? pageSize, int? page}) async {
    NewsDataResponse? response = await CacheNews.getNews();
    return response!;
  }

  @override
  Future<SourcesResponse> getSources(String id) async {
    SourcesResponse response = await CacheSources.getSources();
    return response;
  }
}
