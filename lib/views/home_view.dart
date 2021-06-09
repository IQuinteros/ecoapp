import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/favorites.view.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/categories/category_box.dart';
import 'package:flutter_ecoapp/views/widgets/categories/category_list_item.dart';

import 'package:flutter_ecoapp/views/widgets/mini_button.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';


class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){
    final featuredProducts = EcoAppDebug.getFeaturedProducts();

    final scrollable = Container(
      width: MediaQuery.of(context).size.width,
      height: 290.0,
      child: Swiper(
        itemCount: featuredProducts.length,
        itemBuilder: (BuildContext context, int index){
          return featuredProducts[index];
        },
        loop: false,
        viewportFraction: 0.9,
        scale: 0.9,
        autoplay: true,
        pagination: new SwiperPagination(
          builder: SwiperPagination.rect
        ),
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
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          CategoryBox(
            category: EcoAppDebug.getCategories()[0]
          ),
          CategoryBox(
            category: EcoAppDebug.getCategories()[1]
          ),
          CategoryBox(
            category: EcoAppDebug.getCategories()[2]
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
    
    final categoryView = LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > 490){
          return categoryRow;
        }
        else{
          return Column(
            children: [
              Divider(),
              CategoryListItem(
                category: EcoAppDebug.getCategories()[0],
              ),
              Divider(),
              CategoryListItem(
                category: EcoAppDebug.getCategories()[1]
              ),
              Divider(),
              CategoryListItem(
                category: EcoAppDebug.getCategories()[2]
              ),
              Divider(),
            ],
          );
        }
      }
    );

    final historyList = EcoAppDebug.getArticleItems(initialId: 1);
    final favoriteList = EcoAppDebug.getArticleItems(initialId: 5);

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(),
        EcoTitle(text: 'Productos Destacados'),
        scrollable,
        EcoTitle(
          text: 'Categorías',
          rightButton: MiniButton(
            text: 'Ver mas',
            action: () => Navigator.pushNamed(context, 'categories'),
          )
        ),
        categoryView,
        EcoTitle(
          text: 'Favoritos',
          rightButton: MiniButton(
            text: 'Ver mas',
            action: () => Navigator.push(context, MaterialPageRoute(builder: (__) => FavoritesView())),
          )
        ),
        favoriteList,
        EcoTitle(
          text: 'Historial',
          rightButton: MiniButton(
            text: 'Ver mas',
            action: (){},
          )
        ),
        historyList
      ],
    );

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }
}