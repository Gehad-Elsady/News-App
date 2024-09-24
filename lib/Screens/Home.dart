import 'package:flutter/material.dart';
import 'package:news_app/Models/catigorie-model.dart';
import 'package:news_app/Widgets/catigories-tap.dart';
import 'package:news_app/Screens/catigories.dart';
import 'package:news_app/Widgets/drawer-widget.dart';
import 'package:news_app/Screens/search-tat.dart';
import 'package:news_app/theme/app-color.dart';

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
          color: AppColor.white,
          image: DecorationImage(
              image: AssetImage("assets/images/splash-bg.png"))),
      child: Scaffold(
        drawer: DrawerWidget(
          callBack: onDrawerClicked,
        ),
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
          title: Text(
            'News App',
          ),
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
