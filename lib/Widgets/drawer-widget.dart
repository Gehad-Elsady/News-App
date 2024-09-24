// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:news_app/theme/app-color.dart';

class DrawerWidget extends StatelessWidget {
  Function callBack;
  DrawerWidget({required this.callBack, super.key});

  static const int CATEGORY_ID = 1;
  static const int Sittings_ID = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            color: AppColor.appBar,
            child: Center(
              child: Text(
                'News App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Row(
              children: [
                Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              callBack(CATEGORY_ID);
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.black),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              callBack(Sittings_ID);
            },
          ),
        ],
      ),
    );
  }
}
