import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_ecoapp/views/style/colors.dart';

class CategoryBox extends StatelessWidget {

  final CategoryModel category;

  const CategoryBox({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      category.getIcon(),
      size: 50.0,
      color: EcoAppColors.MAIN_COLOR,
    );

    final card = Card(
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 15.0
        ),
        child: Column(
          children: [
            icon,
            SizedBox(height: 10.0,),
            Text(
              category.title,
              style: GoogleFonts.montserrat(
                fontSize: 15
              ),
            )
          ],
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.0
      ),
      child: MaterialButton(
        child: card,
        padding: EdgeInsets.all(0),
        onPressed: (){},
      ),
    );
  }
}