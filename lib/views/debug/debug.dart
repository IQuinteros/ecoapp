import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/cart_article_card.dart';
import 'package:flutter_ecoapp/views/widgets/home/featured_product.dart';

class EcoAppDebug{

  static Widget getArticleItems(){
    return Column(
      children: [
        ArticleCard(
          title: 'Título largo',
          percent: 80,
          price: 20000,
          favorite: true,
        ),
        ArticleCard(
          title: 'Título largo xd sdjhfhsj dfsd',
          percent: 40,
          price: 35000,
          favorite: false,
        ),
        ArticleCard(
          title: 'Título largo',
          percent: 80,
          price: 20000,
          favorite: true,
        ),
        ArticleCard(
          title: 'Título largo xd sdjhfhsj dfsd',
          percent: 40,
          price: 35000,
          favorite: false,
        ),
      ],
    );
  }

  static Widget getCartArticleItems(){
    return Column(
      children: [
        CartArticleCard(
          title: 'Título largo',
          percent: 80,
          price: 20000,
          favorite: true,
        ),
        CartArticleCard(
          title: 'Título largo xd sdjhfhsj dfsd',
          percent: 40,
          price: 35000,
          favorite: false,
        ),
        CartArticleCard(
          title: 'Título largo',
          percent: 80,
          price: 20000,
          favorite: true,
        ),
        CartArticleCard(
          title: 'Título largo xd sdjhfhsj dfsd',
          percent: 40,
          price: 35000,
          favorite: false,
        ),
      ],
    );
  }

  static List<FeaturedProduct> getFeaturedProducts() => [
    FeaturedProduct(
      imageUrl: 'https://picsum.photos/500/300',
      price: 45000,
      percent: 85,
      title: 'Título del anuncio largo y largo muy',
    ),
    FeaturedProduct(
      imageUrl: 'https://picsum.photos/500/300',
      price: 30000,
      percent: 85,
      title: 'Título del anuncio',
    ),
    FeaturedProduct(
      imageUrl: 'https://picsum.photos/500/300',
      price: 89000,
      percent: 85,
      title: 'Título del anuncio',
    ),
  ];
    
  

}