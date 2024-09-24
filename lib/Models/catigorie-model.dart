import 'package:flutter/material.dart';
import 'package:news_app/theme/app-color.dart';

class CatigorieModel {
  String name;
  String id;
  String image;
  Color color;

  CatigorieModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.color});
  static List<CatigorieModel> getCatigoris() {
    return [
      CatigorieModel(
          name: "Business",
          id: "business",
          image: "assets/images/bussines.png",
          color: AppColor.businessColor),
      CatigorieModel(
          name: "Entertainment",
          id: "entertainment",
          image: "assets/images/environment.png",
          color: AppColor.entertainmentColor),
      CatigorieModel(
          name: "General",
          id: "general",
          image: "assets/images/Politics.png",
          color: AppColor.generalColor),
      CatigorieModel(
          name: "Health",
          id: "health",
          image: "assets/images/health.png",
          color: AppColor.healthColor),
      CatigorieModel(
          name: "Science",
          id: "science",
          image: "assets/images/science.png",
          color: AppColor.scienceColor),
      CatigorieModel(
          name: "Sports",
          id: "sports",
          image: "assets/images/sports.png",
          color: AppColor.sportsColor),
      CatigorieModel(
          name: "Technology",
          id: "technology",
          image: "assets/images/Technology.png",
          color: AppColor.technologyColor),
    ];
  }
}
