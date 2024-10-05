// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_app/blocs/cubit.dart';
import 'package:news_app/blocs/states.dart';
import 'package:news_app/Widgets/news-item.dart';
import 'package:news_app/Widgets/tab-item.dart';
import 'package:news_app/main.dart';
import 'package:news_app/repo/home_local_ds_impl.dart';
import 'package:news_app/repo/home_remote_ds_impl.dart';

class Categories extends StatefulWidget {
  final String id;

  Categories({required this.id, super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int pageSize = 20;
  int page = 1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          if (scrollController.offset != 0) {
            setState(() {
              page++;
              scrollController.animateTo(0,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 300)); // Fixed duration
            });
          }
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) =>
            HomeCubit(isConnectdet ? HomeRemoteDsImpl() : HomeLocalDsImpl())
              ..getSources(widget.id),
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
                  title: const Text("Error"),
                  content:
                      const Text("Something went wrong while fetching news."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text("Close"),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeGetSourcesErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Failed to load news sources")));
            }

            if (state is HomeChangeSource) {
              // Reset page to 1 when source changes and fetch the news
              setState(() {
                page = 1;
              });
              HomeCubit.get(context).getNewsData(
                sourceID: HomeCubit.get(context)
                        .sourcesResponse
                        ?.sources?[HomeCubit.get(context).selectedTabIndex]
                        .id ??
                    "",
                page: page,
                pageSize: pageSize,
              );
            }
          },
          builder: (context, state) {
            final sourcesResponse = HomeCubit.get(context).sourcesResponse;
            final newsDataResponse = HomeCubit.get(context).newsDataResponse;

            if (state is HomeGetSourcesErrorState) {
              return const Center(child: Text("Failed to load sources"));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (sourcesResponse != null &&
                      sourcesResponse.sources != null)
                    DefaultTabController(
                      length: sourcesResponse.sources!.length,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        onTap: (value) {
                          HomeCubit.get(context).changeSource(value);
                        },
                        tabs: sourcesResponse.sources!
                            .map(
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
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: newsDataResponse != null &&
                            newsDataResponse.articles != null
                        ? ListView.builder(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return NewsItem(
                                  articles: newsDataResponse.articles![index]);
                            },
                            itemCount: newsDataResponse.articles!.length,
                          )
                        : const Center(
                            child: Text("No news articles available")),
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
