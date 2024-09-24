import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/NewsDataResponse.dart';
import 'package:news_app/Models/SourcesResponse.dart';
import 'package:news_app/blocs/states.dart';
import 'package:news_app/const/const.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int selectedTabIndex = 0;
  SourcesResponse? sourcesResponse;
  NewsDataResponse? newsDataResponse;

  changeSource(int value) {
    selectedTabIndex = value;
    emit(HomeChangeSource());
  }

  Future<void> getSources(String id) async {
    try {
      emit(HomeGetSourcesLoadingState());
      Uri url = Uri.https("newsapi.org", "/v2/top-headlines/sources",
          {"apiKey": Constants.apiKey, "category": id});
      http.Response response = await http.get(url);

      var json = jsonDecode(response.body);

      sourcesResponse = SourcesResponse.fromJson(json);
      emit(HomeGetSourcesSuccessState());
      getNewsData(
          sourceID: sourcesResponse?.sources?[selectedTabIndex].id ?? "");
    } catch (e) {
      emit(HomeGetSourcesErrorState());
    }
  }

  Future<void> getNewsData(
      {String? sourceID, String? query, int? pageSize, int? page}) async {
    try {
      emit(HomeGetNewsDataLoadingState());

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

      if (response.statusCode != 200) {
        emit(HomeGetNewsDataErrorState());
        return;
      }

      var json = jsonDecode(response.body);
      newsDataResponse = NewsDataResponse.fromJson(json);
      emit(HomeGetNewsDataSuccessState());
    } catch (e) {
      // Log error for better debugging
      print("Error fetching news data: $e");
      emit(HomeGetNewsDataErrorState());
    }
  }
}
