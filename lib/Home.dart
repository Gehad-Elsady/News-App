import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Api-Manegar.dart';
import 'package:news_app/catigories.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/splash-bg.png"))),
      child: Scaffold(
        drawer: Drawer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 93,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'News App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          )),
        ),
        body: Column(
          children: [
            Categories(),
          ],
        ),
      ),
    );
  }
}
