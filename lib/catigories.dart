import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Api-Manegar.dart';

class Categories extends StatefulWidget {
  Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int? value;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        var sources = snapshot.data?.sources ?? [];
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 5.0,
            children: List<Widget>.generate(
              sources.length,
              (int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    left: 8,
                    top: 16,
                  ),
                  child: ChoiceChip(
                    label: Text(
                      sources[index].name ?? "",
                      style: GoogleFonts.poppins(
                          color: value == index ? Colors.white : Colors.green,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    selected: value == index,
                    backgroundColor: Colors.transparent,
                    selectedColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(
                          color: Colors.green,
                          width: 2.0,
                        )),
                    onSelected: (bool selected) {
                      setState(() {
                        value = selected ? index : null;
                      });
                    },
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
