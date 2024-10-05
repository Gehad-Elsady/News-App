import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/NewsDataResponse.dart';
import 'package:news_app/Models/SourcesResponse.dart';
import 'package:news_app/blocs/states.dart';
import 'package:news_app/const/const.dart';
import 'package:news_app/repo/repo.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeRepo repo;
  HomeCubit(this.repo) : super(HomeInitState());

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
      sourcesResponse = await repo.getSources(id);
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
      newsDataResponse = await repo.getNewsData(
          sourceID: sourceID, query: query, pageSize: pageSize, page: page);
      emit(HomeGetNewsDataSuccessState());
    } catch (e) {
      // Log error for better debugging
      print("Error fetching news data: $e");
      emit(HomeGetNewsDataErrorState());
    }
  }
}
