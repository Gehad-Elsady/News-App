import 'package:flutter/material.dart';
import 'package:news_app/SourcesResponse.dart';

// ignore: must_be_immutable
class TabItems extends StatelessWidget {
  Sources sources;
  bool isSelected;
  TabItems({required this.isSelected, required this.sources, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? Colors.green : Colors.white,
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          sources.name ?? "",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.green,
            fontSize: 18,
          ),
        ));
  }
}
