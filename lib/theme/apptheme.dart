// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/theme/app-color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.scaffold,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      )),
      toolbarHeight: 93,
      color: AppColor.appBar,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  );
}
