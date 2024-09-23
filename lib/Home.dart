import 'package:flutter/material.dart';
import 'package:news_app/catigorie-model.dart';
import 'package:news_app/catigories-tap.dart';
import 'package:news_app/catigories.dart';
import 'package:news_app/drawer-widget.dart';
import 'package:news_app/search-tat.dart';

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
        drawer: DrawerWidget(
          callBack: onDrawerClicked,
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            catigorieModel == null
                ? SizedBox()
                : IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: SearchTab());
                    },
                    icon: Icon(
                      Icons.search_rounded,
                      size: 30,
                    ))
          ],
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
        body: catigorieModel == null
            ? CatigoriesTap(
                onClick: onCatigoriesClick,
              )
            : Categories(
                id: catigorieModel!.id,
              ),
      ),
    );
  }

  CatigorieModel? catigorieModel = null;
  onCatigoriesClick(cat) {
    catigorieModel = cat;
    setState(() {});
  }

  onDrawerClicked(id) {
    if (id == DrawerWidget.CATEGORY_ID) {
      catigorieModel = null;
      Navigator.pop(context);
    } else if (id == DrawerWidget.Sittings_ID) {}
    setState(() {});
  }
}
