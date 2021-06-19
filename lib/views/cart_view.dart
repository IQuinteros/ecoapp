import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/views/login_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/summary_view.dart';
import 'package:flutter_ecoapp/views/widgets/articles/cart_article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/mini_eco_indicator.dart';
import 'package:flutter_ecoapp/views/widgets/index_app_bar.dart';
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
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            IndexAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  getContent(context)
                ]
              ),
            )
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
                  onPressed: (){
                    _buy(context);
                  },
                  visible: cartBloc.loadedArticles.length > 0,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  int loadedElements = 0;
  int _deletedElements = 0;
  Widget getContent(BuildContext context){

    final cartBloc = BlocProvider.of<CartBloc>(context);
    // TODO: With API change for getCart()

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                if(cartBloc.loadedArticles.length <= 0){
                  cartArticles.add(SizedBox(height: 13.0));
                  cartArticles.add(
                    Text(
                      'Estamos actualizando tus artículos',
                      style: GoogleFonts.montserrat(),
                      textAlign: TextAlign.center,
                    ),  
                  );
                }
                cartArticles.add(SizedBox(height: 20.0));
                continue display;
              display:
              case ConnectionState.done:

                loadedElements = cartBloc.loadedArticles.length;
                
                cartArticles.addAll(cartBloc.loadedArticles.map<Widget>((e) => CartArticleCard(
                  key: Key('cart_article${e.id}${e.articleId}'),
                  article: e.article!,
                  initialQuantity: e.quantity,
                  onDelete: () {
                    if(cartBloc.loadedArticles.length <= 0) _resetState();
                  }//_resetState(),
                )).toList());

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

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }

  void _resetState() => setState(() {});

  void _buy(BuildContext context){
    final cartBloc = BlocProvider.of<CartBloc>(context);
    
    if(cartBloc.loadedArticles.length <= 0){
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No hay artículos en el carrito para comprar'),
        backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    if(profileBloc.currentProfile == null) {
      displayProfileMessage(context);
      return;
    }
    
    Navigator.push(context, MaterialPageRoute(builder: (__) => SummaryView()));
  }

  void displayProfileMessage(BuildContext context){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Debe iniciar sesión para marcar el artículo como favorito'),
      backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      action: SnackBarAction(
        label: "Iniciar sesión",
        textColor: EcoAppColors.ACCENT_COLOR,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (__) => LoginView())),
      ),
    ));
  }
}