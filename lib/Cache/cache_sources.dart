import 'package:hive/hive.dart';
import 'package:news_app/Models/SourcesResponse.dart';
import 'package:path_provider/path_provider.dart';

class CacheSources {
  static Future<void> saveSources(SourcesResponse response) async {
    final directory = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'SourcesList',
      {'sources'},
      path: directory.path,
    );

    // Open your boxes. Optional: Give it a type.
    final sourcesBox = await collection.openBox<Map>('sources');
    await sourcesBox.put("sources", response.toJson());
    print("-------------saved date--------------");
  }

  static Future<SourcesResponse> getSources() async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'SourcesList',
      {'sources'},
      path: directory.path,
    );

    // Open your boxes. Optional: Give it a type.
    final sourcesBox = await collection.openBox<Map>('sources');
    var response = await sourcesBox.get("sources");
    print("-------------get date--------------");

    return SourcesResponse.fromJson(response!);
  }
}
