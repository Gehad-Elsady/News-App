import 'package:flutter/material.dart';
import 'package:news_app/catigorie-model.dart';

class CatigoriesItems extends StatelessWidget {
  CatigorieModel catigoriesModel;
  bool isOdd;
  CatigoriesItems(
      {required this.isOdd, required this.catigoriesModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: isOdd ? Radius.circular(25) : Radius.zero,
          bottomLeft: !isOdd ? Radius.circular(25) : Radius.zero,
        ),
        color: catigoriesModel.color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              catigoriesModel.image,
              width: 150,
            ),
          ),
          Text(
            catigoriesModel.name,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}
