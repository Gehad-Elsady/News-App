import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/cubit.dart';
import 'package:news_app/blocs/states.dart';
import 'package:news_app/news-item.dart';

class SearchTab extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showResults(context);
        },
      ),
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context); // Go back
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getNewsData(query: query),
      child: BlocConsumer<HomeCubit, HomeStates>(
        builder: (BuildContext context, HomeStates state) {
          if (state is HomeGetNewsDataSuccessState) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                return NewsItem(
                  articles:
                      HomeCubit.get(context).newsDataResponse!.articles![index],
                );
              },
              itemCount:
                  HomeCubit.get(context).newsDataResponse?.articles?.length ??
                      0,
            );
          } else if (state is HomeGetNewsDataErrorState) {
            return Center(child: Text("No data"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        listener: (BuildContext context, HomeStates state) {},
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Type something to search'));
    }

    return BlocProvider(
      create: (context) => HomeCubit()..getNewsData(query: query),
      child: BlocConsumer<HomeCubit, HomeStates>(
        builder: (BuildContext context, HomeStates state) {
          if (state is HomeGetNewsDataSuccessState) {
            if (HomeCubit.get(context).newsDataResponse?.articles?.isEmpty ??
                true) {
              return Center(child: Text("No suggestions found"));
            }

            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                return NewsItem(
                  articles:
                      HomeCubit.get(context).newsDataResponse!.articles![index],
                );
              },
              itemCount:
                  HomeCubit.get(context).newsDataResponse?.articles?.length ??
                      0,
            );
          } else if (state is HomeGetNewsDataErrorState) {
            return Center(child: Text("Error fetching suggestions"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        listener: (BuildContext context, HomeStates state) {},
      ),
    );
  }
}
