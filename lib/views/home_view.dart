import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';

import 'package:flutter_ecoapp/views/widgets/home/featured_product.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';


class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContent(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: EcoAppColors.MAIN_COLOR,
        selectedItemColor: EcoAppColors.ACCENT_COLOR,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile'
          )
        ],
      ),
    );
  }

  Widget getContent(BuildContext context){
    final title = Container(
      margin: EdgeInsets.only(
        left: 30.0,
        top: 20.0
      ),
      child: Text(
        'Productos destacados',
        style: EcoAppTextStyle.TITLE_STYLE,
        textAlign: TextAlign.start,
      ),
    );

    final featuredProducts = Row(
      children: [
        FeaturedProduct(
          imageUrl: 'https://picsum.photos/500/300',
          price: 45000,
          percent: 85,
          title: 'Título del anuncio',
        ),
        FeaturedProduct(
          imageUrl: 'https://picsum.photos/500/300',
          price: 45000,
          percent: 85,
          title: 'Título del anuncio',
        ),
      ],
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(),
        title,
        scrollable
      ],
    );
  }
}