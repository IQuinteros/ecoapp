import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/cart.dart';

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
          builder: (BuildContext context, AsyncSnapshot<List<CartArticleModel>> snapshot){
            List<Widget> cartArticles = [];
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.active:
                cartArticles.add(LinearProgressIndicator());
                cartArticles.add(SizedBox(height: 13.0));
                cartArticles.add(
                  Text(
                    'Estamos actualizando tus artículos',
                    style: GoogleFonts.montserrat(),
                    textAlign: TextAlign.center,
                  ),  
                );
                cartArticles.add(SizedBox(height: 20.0));
                continue display;
              display:
              case ConnectionState.done:
                
                cartArticles.addAll(cartBloc.loadedArticles.map<Widget>((e) => CartArticleCard(
                  key: Key('cart_article${e.id}${e.articleId}'),
                  article: e.article!,
                  initialQuantity: e.quantity,
                  onDelete: () => {}//_resetState(),
                )).toList());

                cartArticles.forEach((element) { 
                  if(element is CartArticleCard){
                    print('initial quantity: ${element.initialQuantity}');
                  }
                });

                if(snapshot.connectionState == ConnectionState.done && snapshot.data!.length <= 0){
                  cartArticles.add(SizedBox(height: 15.0));
                  cartArticles.add(
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Aún no tienes artículos en tu carrito',
                          style: GoogleFonts.montserrat(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  );
                }

                cartArticles.add(SizedBox(height: 100.0));

                final content = Column(
                  children: cartArticles
                );
                return content;
              default: return Container();
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

  void _resetState() => setState(() {});
}