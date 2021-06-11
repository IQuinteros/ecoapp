import 'dart:ui';

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
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
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
          future: cartBloc.loadCart(),
          initialData: cartBloc.loadedArticles,
          builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot){
            List<Widget> cartArticles = [];
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.active:
                cartArticles.add(LinearProgressIndicator());
                cartArticles.add(SizedBox(height: 10.0));
                continue display;
              display:
              case ConnectionState.done:
                print(snapshot.data!.length);
                
                cartArticles.addAll(snapshot.data!.map<CartArticleCard>((e) => CartArticleCard(
                  article: e,
                  onDelete: () => setState(() {}),
                )).toList());

                cartArticles.add(SizedBox(height: 100.0));
                
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(),
                    SizedBox(height: 40.0),
                    Text(
                      'Estamos actualizando tus artículos',
                      style: GoogleFonts.montserrat(),
                      textAlign: TextAlign.center,
                    ),                 
                  ],
                ),
              );
            }
          }
        )
      ],
    );

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: column,
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                height: 50.0,
                constraints: BoxConstraints(
                  minHeight: 50.0
                ),
                child: NormalButton(
                text: 'Reservar pedido', 
                onPressed: (){}
                ),
              ),
            ),
          ),
        )
      ]
    );
  }
}