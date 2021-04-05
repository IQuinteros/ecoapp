import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/categories/category_box.dart';

import 'package:flutter_ecoapp/views/widgets/home/featured_product.dart';
import 'package:flutter_ecoapp/views/widgets/mini_button.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';


class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){
    final featuredProducts = Row(
      children: EcoAppDebug.getFeaturedProducts()
    );

    final scrollable = Container(
      child: SingleChildScrollView(
        child: featuredProducts,
        scrollDirection: Axis.horizontal,
      ),
      margin: EdgeInsets.only(
        top: 20.0
      ),
    );

    final categoryRow = Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CategoryBox(
              iconData: Icons.ac_unit,
              text: 'A granel',
            ),
            CategoryBox(
              iconData: Icons.badge,
              text: 'Bolsas',
            ),
            CategoryBox(
              iconData: Icons.clean_hands,
              text: 'Limpieza'
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );

    final favoriteList = EcoAppDebug.getArticleItems();

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(),
        EcoAppTextStyle.getTitle('Productos Destacados'),
        scrollable,
        EcoAppTextStyle.getTitle(
          'Categorías',
          rightButton: MiniButton(
            text: 'Ver mas',
            action: (){},
          )
        ),
        categoryRow,
        EcoAppTextStyle.getTitle(
          'Favoritos',
          rightButton: MiniButton(
            text: 'Ver mas',
            action: (){},
          )
        ),
        favoriteList,
        EcoAppTextStyle.getTitle(
          'Historial',
          rightButton: MiniButton(
            text: 'Ver mas',
            action: (){},
          )
        ),
        favoriteList
      ],
    );

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }
}