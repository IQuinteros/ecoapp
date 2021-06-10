import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/store.dart';

import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/cart_article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/mini_eco_indicator.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:google_fonts/google_fonts.dart';


class CartView extends StatefulWidget {

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){

    final cartBloc = BlocProvider.of<CartBloc>(context);
    // TODO: With API change for getCart()

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(),
        EcoTitle(
          text: 'Carrito',
          rightButton: MiniEcoIndicator( // TODO: Only debug indicator
            ecoIndicator: EcoIndicator(
              hasRecycledMaterials: true,
              hasReuseTips: true,
              isRecyclableProduct: true
            ),
          ),
        ),
        FutureBuilder(
          future: cartBloc.getCartArticles(),
          builder: (BuildContext context, AsyncSnapshot<List<CartArticleModel>> snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.done:
                 List<CartArticleCard> cartArticles = snapshot.data!.map<CartArticleCard>((e) => CartArticleCard(
                  article: ArticleModel(
                    id: e.articleId,
                    title: 'Article id: ${e.articleId}',
                    category: CategoryModel(id: 1, title: '', createdDate: DateTime.now()),
                    description: 'Large description',
                    createdDate: DateTime.now(),
                    enabled: true,
                    form: ArticleForm(
                      id: 1, 
                      createdDate: DateTime.now(), 
                      lastUpdateDate: DateTime.now(),
                      generalDetail: '',
                      recycledMats: '',
                      recycledMatsDetail: '',
                      recycledProd: '',
                      recycledProdDetail: '',
                      reuseTips: ''
                    ),
                    lastUpdateDate: DateTime.now(),
                    price: 200,
                    rating: ArticleRating(
                      opinions: []
                    ),
                    stock: 2,
                    pastPrice: 200,
                    store: StoreModel(
                      contactNumber: 1,
                      createdDate: DateTime.now(),
                      description: '',
                      district: DistrictModel(id: 1, name: 'Penco'),
                      email: '',
                      enabled: true,
                      id: 1,
                      lastUpdateDate: DateTime.now(),
                      location: '',
                      publicName: 'TEST',
                      rut: 2,
                      rutDv: ''
                    )
                  ),
                  onDelete: () => setState(() {}),
                )).toList();

                final content = Column(
                  children: cartArticles
                );
                return content;
              default: return Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                  right: 20.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(),
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Estamos actualizando tus artículos',
                          style: GoogleFonts.montserrat(),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    ),                  
                  ],
                ),
              );
            }
          }
        )
      ],
    );

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }
}