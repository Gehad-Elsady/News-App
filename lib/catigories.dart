// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_app/blocs/cubit.dart';
import 'package:news_app/blocs/states.dart';
import 'package:news_app/news-item.dart';
import 'package:news_app/tab-item.dart';

class Categories extends StatelessWidget {
  String id;

  Categories({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) => HomeCubit()..getSources(id),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is HomeGetSourcesLoadingState ||
                state is HomeGetNewsDataLoadingState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state is HomeGetNewsDataErrorState) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text("Something went wrong"),
                ),
              );
            }

            if (state is HomeGetSourcesErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Something went wrong")));
            }

            if (state is HomeChangeSource) {
              HomeCubit.get(context).getNewsData(
                  sourceID: HomeCubit.get(context)
                          .sourcesResponse
                          ?.sources?[HomeCubit.get(context).selectedTabIndex]
                          .id ??
                      "");
            }
          },
          builder: (context, state) {
            if (state is HomeGetSourcesErrorState) {
              return Text("Something went wrong");
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DefaultTabController(
                    length: HomeCubit.get(context)
                            .sourcesResponse
                            ?.sources
                            ?.length ??
                        0,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      onTap: (value) {
                        HomeCubit.get(context).changeSource(value);
                      },
                      tabs: HomeCubit.get(context)
                              .sourcesResponse
                              ?.sources
                              ?.map(
                                (e) => TabItems(
                                  sources: e,
                                  isSelected: HomeCubit.get(context)
                                          .sourcesResponse!
                                          .sources!
                                          .elementAt(HomeCubit.get(context)
                                              .selectedTabIndex) ==
                                      e,
                                ),
                              )
                              .toList() ??
                          [],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8,
                      ),
                      itemBuilder: (context, index) {
                        return NewsItem(
                            articles: HomeCubit.get(context)
                                .newsDataResponse!
                                .articles![index]);
                      },
                      itemCount: HomeCubit.get(context)
                              .newsDataResponse
                              ?.articles
                              ?.length ??
                          0,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
