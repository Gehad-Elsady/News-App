import 'package:news_app/Models/NewsDataResponse.dart';
import 'package:news_app/Models/SourcesResponse.dart';

abstract class HomeRepo {
  Future<SourcesResponse> getSources(String id);
  Future<NewsDataResponse> getNewsData(
      {String? sourceID, String? query, int? pageSize, int? page});
}
