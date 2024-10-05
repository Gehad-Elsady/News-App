import 'package:hive/hive.dart';
import 'package:news_app/Models/NewsDataResponse.dart';
import 'package:path_provider/path_provider.dart';

class CacheNews {
  static Future<void> saveNews(NewsDataResponse response) async {
    final directory = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'NewsList',
      {'news'},
      path: directory.path,
    );

    // Open your boxes. Optional: Give it a type.
    final newsBox = await collection.openBox<Map>('news');

    // Convert the NewsDataResponse to JSON (Map format) before saving
    final newsJson = response.toJson();

    // Save the JSON data
    await newsBox.put("news", newsJson);
    print("-------------saved data news--------------");
  }

  static Future<NewsDataResponse?> getNews() async {
    final directory = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'NewsList',
      {'news'},
      path: directory.path,
    );

    final newsBox = await collection.openBox<Map>('news');
    var newsJson = await newsBox.get("news");
    print("-------------retrieved data--------------");
    return NewsDataResponse.fromJson(newsJson!);
  }
}
