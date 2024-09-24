import 'package:flutter/material.dart';
import 'package:news_app/Models/catigorie-model.dart';
import 'package:news_app/Widgets/catigories-items.dart';

class CatigoriesTap extends StatelessWidget {
  Function onClick;
  CatigoriesTap({required this.onClick, super.key});

  var cattegorise = CatigorieModel.getCatigoris();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            "Pick your category of interest",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onClick(cattegorise[index]);
                  },
                  child: CatigoriesItems(
                    catigoriesModel: cattegorise[index],
                    isOdd: index.isOdd,
                  ),
                );
              },
              itemCount: cattegorise.length,
            ),
          )
        ],
      ),
    );
  }
}
