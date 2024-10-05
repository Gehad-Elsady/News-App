import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/Models/NewsDataResponse.dart';
import 'package:news_app/Screens/news-detalies.dart';

class NewsItem extends StatelessWidget {
  Articles articles;
  NewsItem({required this.articles, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          Navigator.pushNamed(context, NewsDetails.routeName,
              arguments: articles);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    articles.urlToImage ?? "",
                    height: 240,
                  )),
              Text(
                articles.source?.name ?? "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                articles.title ?? "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                articles.description ?? "",
                maxLines: 3,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                articles.publishedAt?.substring(0, 10) ?? "",
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
