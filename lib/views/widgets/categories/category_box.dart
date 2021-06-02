import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/views/result_view.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_ecoapp/views/style/colors.dart';

class CategoryBox extends StatelessWidget {

  final CategoryModel category;

  const CategoryBox({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      category.getIcon(),
      size: 50.0,
      color: EcoAppColors.MAIN_COLOR,
    );

    final card = Card(
      elevation: 5.0,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 15.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(height: 10.0,),
              Text(
                category.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 15
                ),
              )
            ],
          ),
        ),
      ),
    );

    return Expanded(
      flex: 1,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 130.0,
          maxWidth: double.infinity,
          minWidth: 150.0
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 5.0
        ),
        child: MaterialButton(
          child: card,
          padding: EdgeInsets.all(0),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (__) => ResultView(searching: category.toString(),))),
        ),
      ),
    );
  }
}