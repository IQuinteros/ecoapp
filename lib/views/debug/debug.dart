import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/cart_article_card.dart';
import 'package:flutter_ecoapp/views/widgets/home/featured_product.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class EcoAppDebug{


  static Widget getArticleItems({int initialId = 1}){
    return Column(
      children: [
        ArticleCard(
          article: ArticleModel(
            id: initialId,
            title: 'Tìtulo largo',
            price: 20000.0,
            description: lipsum.createParagraph(numParagraphs: 2),
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now(),
            photos: [
              PhotoModel(id: 1, photoUrl: 'https://picsum.photos/500/300')
            ],
            form: ArticleForm(
              id: 1,
              createdDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
              recycledMats: 'Full',
              recycledMatsDetail: lipsum.createParagraph(numParagraphs: 1),
              recycledProd: 'Full',
              recycledProdDetail: lipsum.createParagraph(numParagraphs: 1),
              reuseTips: lipsum.createParagraph(numParagraphs: 1)
            ),
            store: getStores()[0]
          ),
          favorite: true,
        ),
        ArticleCard(
          article: ArticleModel(
            id: initialId + 1,
            title: 'Tìtulo muy muy largo sdjkfsdffdsjkdfjkssds',
            price: 20000.0,
            description: lipsum.createParagraph(numParagraphs: 2),
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now(),
            photos: [
              PhotoModel(id: 2, photoUrl: 'https://picsum.photos/500/300')
            ],
            form: ArticleForm(
              id: 2,
              createdDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
              recycledProd: 'Full',
              recycledProdDetail: lipsum.createParagraph(numParagraphs: 1),
              reuseTips: lipsum.createParagraph(numParagraphs: 1)
            ),
            store: getStores()[2]
          ),
          favorite: false,
        ),
        ArticleCard(
          article: ArticleModel(
            id: initialId + 2,
            title: 'Tìtulo largo',
            price: 9021545.0,
            description: lipsum.createParagraph(numParagraphs: 2),
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now(),
            photos: [
              PhotoModel(id: 3, photoUrl: 'https://picsum.photos/500/300')
            ],
            form: ArticleForm(
              id: 3,
              createdDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
              recycledMats: 'Full',
              recycledMatsDetail: lipsum.createParagraph(numParagraphs: 1),
              recycledProd: 'Full',
              recycledProdDetail: lipsum.createParagraph(numParagraphs: 1),
            ),
            store: getStores()[1]
          ),
          favorite: true,
        ),
        ArticleCard(
          article: ArticleModel(
            id: initialId + 3,
            title: 'Tìtulo uy muy largo sdjkfsdffdsjkdfjkssd sdafasdfasdf asdfasdfasds',
            price: 2000000.0,
            description: lipsum.createParagraph(numParagraphs: 2),
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now(),
            photos: [
              PhotoModel(id: 4, photoUrl: 'https://picsum.photos/500/300')
            ],
            form: ArticleForm(
              id: 4,
              createdDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
              recycledProd: 'Full',
              recycledProdDetail: lipsum.createParagraph(numParagraphs: 1),
              reuseTips: lipsum.createParagraph(numParagraphs: 1)
            ),
            store: getStores()[0]
          ),
          favorite: false,
        ),
        ArticleCard(
          article: ArticleModel(
            id: initialId + 4,
            title: 'Tìtulo uy muy largo asdf asdfasdfasds',
            price: 2000000.0,
            description: lipsum.createParagraph(numParagraphs: 2),
            stock: 2,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now(),
            photos: [
              PhotoModel(id: 5, photoUrl: 'https://picsum.photos/500/300')
            ],
            form: ArticleForm(
              id: 5,
              createdDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
            ),
            store: getStores()[0]
          ),
          favorite: false,
        ),
        ArticleCard(
          article: ArticleModel(
            id: initialId + 5,
            title: 'Tìtulo uy muy largo asdf asdfasdfasds',
            price: 90000.0,
            description: lipsum.createParagraph(numParagraphs: 2),
            stock: 4,
            enabled: true,
            lastUpdateDate: DateTime.now(),
            createdDate: DateTime.now(),
            photos: [
              PhotoModel(id: 6, photoUrl: 'https://picsum.photos/500/300')
            ],
            form: ArticleForm(
              id: 6,
              createdDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
              recycledProd: 'Full',
              recycledProdDetail: lipsum.createParagraph(numParagraphs: 1),
            ),
            store: getStores()[2]
          ),
          favorite: false,
        ),
      ],
    );
  }

  static List<StoreModel> getStores(){
    return [
      StoreModel(
        id: 1, 
        publicName: 'EcoTienda 1', 
        description: lipsum.createParagraph(numParagraphs: 1), 
        email: 'ecotienda@eco.cl', 
        contactNumber: 912345678, 
        location: 'Ecolugar de Chile', 
        rut: 12345678, 
        rutDv: '1', 
        enabled: true, 
        createdDate: DateTime.now(), 
        lastUpdateDate: DateTime.now(), 
        district: DistrictModel(
          id: 1,
          name: 'Concepción'
        )
      ),
      StoreModel(
        id: 2, 
        publicName: 'EcoTienda 2', 
        description: lipsum.createParagraph(numParagraphs: 1), 
        email: 'ecotienda2@eco.cl', 
        contactNumber: 912345678, 
        location: 'Ecolugar 2 de Chile', 
        rut: 12345678, 
        rutDv: '2', 
        enabled: false, 
        createdDate: DateTime.now(), 
        lastUpdateDate: DateTime.now(), 
        district: DistrictModel(
          id: 1,
          name: 'Penco'
        )
      ),
      StoreModel(
        id: 3, 
        publicName: 'EcoTienda 3', 
        description: lipsum.createParagraph(numParagraphs: 1), 
        email: 'ecotienda3@eco.cl', 
        contactNumber: 912345678, 
        location: 'Ecolugar 3 de Chile', 
        rut: 12345678, 
        rutDv: '3', 
        enabled: true, 
        createdDate: DateTime.now(), 
        lastUpdateDate: DateTime.now(), 
        district: DistrictModel(
          id: 1,
          name: 'Talcahuano'
        )
      ),
    ];
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
      article: ArticleModel(
        id: 10 + 2,
        title: 'Tìtulo largo',
        price: 9021545.0,
        description: lipsum.createParagraph(numParagraphs: 2),
        stock: 2,
        enabled: true,
        lastUpdateDate: DateTime.now(),
        createdDate: DateTime.now(),
        photos: [
          PhotoModel(id: 3, photoUrl: 'https://picsum.photos/500/300')
        ],
        form: ArticleForm(
          id: 3,
          createdDate: DateTime.now(),
          lastUpdateDate: DateTime.now(),
          recycledMats: 'Full',
          recycledMatsDetail: lipsum.createParagraph(numParagraphs: 1),
          recycledProd: 'Full',
          recycledProdDetail: lipsum.createParagraph(numParagraphs: 1),
        ),
        store: getStores()[1]
      ),
    ),
    FeaturedProduct(
      article: ArticleModel(
        id: 10 + 3,
        title: 'Tìtulo largo',
        price: 9021545.0,
        description: lipsum.createParagraph(numParagraphs: 2),
        stock: 2,
        enabled: true,
        lastUpdateDate: DateTime.now(),
        createdDate: DateTime.now(),
        photos: [
          PhotoModel(id: 3, photoUrl: 'https://picsum.photos/500/300')
        ],
        form: ArticleForm(
          id: 3,
          createdDate: DateTime.now(),
          lastUpdateDate: DateTime.now(),
          recycledMats: 'Full',
          recycledMatsDetail: lipsum.createParagraph(numParagraphs: 1),
          recycledProd: 'Full',
          recycledProdDetail: lipsum.createParagraph(numParagraphs: 1),
        ),
        store: getStores()[1]
      ),
    ),
    FeaturedProduct(
      article: ArticleModel(
        id: 10 + 4,
        title: 'Tìtulo largo',
        price: 9021545.0,
        description: lipsum.createParagraph(numParagraphs: 2),
        stock: 2,
        enabled: true,
        lastUpdateDate: DateTime.now(),
        createdDate: DateTime.now(),
        photos: [
          PhotoModel(id: 3, photoUrl: 'https://picsum.photos/500/300')
        ],
        form: ArticleForm(
          id: 3,
          createdDate: DateTime.now(),
          lastUpdateDate: DateTime.now(),
          recycledMats: 'Full',
          recycledMatsDetail: lipsum.createParagraph(numParagraphs: 1),
          recycledProd: 'Full',
          recycledProdDetail: lipsum.createParagraph(numParagraphs: 1),
        ),
        store: getStores()[1]
      ),
    ),
  ];
    
  static List<CategoryModel> getCategories(){
    return [
      CategoryModel(id: 1, title: 'Hogar', createdDate: DateTime.now()),
      CategoryModel(id: 2, title: 'Cuidado Personal', createdDate: DateTime.now()),
      CategoryModel(id: 3, title: 'Alimentos', createdDate: DateTime.now()),
    ];
  }

}