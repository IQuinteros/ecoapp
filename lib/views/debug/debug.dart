import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/cart_article_card.dart';
import 'package:flutter_ecoapp/views/widgets/home/featured_product.dart';

class EcoAppDebug{

  static Widget getArticleItems(){
    return Column(
      children: [
        ArticleCard(
          article: ArticleModel(
            id: 1,
            title: 'Tìtulo largo',
            price: 20000.0,
            description: 'Descripción larga',
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now()
          ),
          favorite: true,
        ),
        ArticleCard(
          article: ArticleModel(
            id: 1,
            title: 'Tìtulo muy muy largo sdjkfsdffdsjkdfjkssds',
            price: 20000.0,
            description: 'Descripción larga',
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now()
          ),
          favorite: false,
        ),
        ArticleCard(
          article: ArticleModel(
            id: 1,
            title: 'Tìtulo largo',
            price: 9021545.0,
            description: 'Descripción larga',
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now()
          ),
          favorite: true,
        ),
        ArticleCard(
          article: ArticleModel(
            id: 1,
            title: 'Tìtulo uy muy largo sdjkfsdffdsjkdfjkssd sdafasdfasdf asdfasdfasds',
            price: 2000000.0,
            description: 'Descripción larga',
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now()
          ),
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