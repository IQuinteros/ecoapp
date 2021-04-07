import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/categories/category_box.dart';

import 'package:flutter_ecoapp/views/widgets/home/featured_product.dart';
import 'package:flutter_ecoapp/views/widgets/mini_button.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:google_fonts/google_fonts.dart';


class CartView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(),
        EcoAppTextStyle.getTitle('Carrito',
          rightButton: Text(
            '80%',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: EcoAppColors.MAIN_COLOR
            ),
          )
        ),
        EcoAppDebug.getCartArticleItems()
      ],
    );

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }
}