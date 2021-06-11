import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/opinions_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/articleview/article_description_section.dart';
import 'package:flutter_ecoapp/views/widgets/articles/articleview/article_eco_detail_section.dart';
import 'package:flutter_ecoapp/views/widgets/articles/articleview/article_photo_section.dart';
import 'package:flutter_ecoapp/views/widgets/articles/articleview/article_question_section.dart';
import 'package:flutter_ecoapp/views/widgets/articles/articleview/article_store_description_section.dart';
import 'package:flutter_ecoapp/views/widgets/articles/articleview/full_eco_indicator.dart';
import 'package:flutter_ecoapp/views/widgets/articles/favorite_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class ArticleView extends StatelessWidget {

  final ArticleModel article;

  const ArticleView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContent(context),
    );
  }

  Widget getContent(BuildContext context){
    return CustomScrollView(
      slivers: [
        _ArticleAppBar(article: article),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _ArticleMainContent(article: article)
            ]
          ),
        )
      ],
    );
  }

}

class _ArticleAppBar extends StatelessWidget {
  const _ArticleAppBar({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 10.0,
      backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      foregroundColor: Colors.white,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: (){
            Share.share(
              '¡Disponible en Ecomercio! ${article.title} a solo \$${CurrencyUtil.formatToCurrencyString(article.price.toInt())}'
            );
          },
        ),
        FavoriteButton(favorite: false, disabledColor: Colors.white,)
      ],
      title: Text(
        article.title,
        style: TextStyle(
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black,
            )
          ]
        ),
      ),
      stretch: true,
      forceElevated: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        background: Hero( 
          tag: article.tag,
          child: Image(
            image: NetworkImage(article.photos.length > 0? article.photos[0].photoUrl : 'https://picsum.photos/500/400'),
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}

class _ArticleMainContent extends StatelessWidget {
  const _ArticleMainContent({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        /* boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20.0
          )
        ] */
      ),
      margin: EdgeInsets.only(
        left: 5.0,
        right: 5.0
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: SafeArea(
        child: _ArticleContent(article: article,),
        top: false,
      ),
    );
  }
}


class _ArticleContent extends StatelessWidget {
  const _ArticleContent({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {

    final title = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: Container(
        width: double.infinity,
        child: Text(
          article.title,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.left,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );

    final rating = InkWell(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.0,
          left: 20.0,
          right: 20.0,
          bottom: 10.0
        ),
        child: Row(
          children: [
            StarsRow(rating: article.rating.avgRating),
            SizedBox(width: 10.0),
            Text(
              '${article.rating.count} opiniones',
              style: GoogleFonts.montserrat(
                color: EcoAppColors.MAIN_COLOR
              ),
            )
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (__) => OpinionsView(article: article,))
      )
    );

    // Only display when past price is higher than 0, and is higher than the current price
    bool havePastPrice = article.pastPrice != null && article.pastPrice! > 0 && article.pastPrice! > article.price;

    final price = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: Row(
        children: [
          Text(
            '\$ ' + CurrencyUtil.formatToCurrencyString(article.price.floor()),
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(width: 30.0,),
          havePastPrice? Text(
            '\$ ' + CurrencyUtil.formatToCurrencyString(article.pastPrice!.floor()),
            style: GoogleFonts.montserrat(
              decoration: TextDecoration.lineThrough
            ),
          ) : Container(),
        ],
      ),
    );

    final storeText = InkWell(
      onTap: () => print('Go to store'), // TODO: Go to store
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0
        ),
        child: Container(
          width: double.infinity,
          child: RichText(
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            text: TextSpan(
              text: 'Vendido por ',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 15
              ),
              children: [
                TextSpan(
                  text: '${article.store!.publicName}',
                  style: GoogleFonts.montserrat(
                    color: EcoAppColors.MAIN_COLOR
                  ),
                )
              ]
            ),
          ),
        )
      ),
    );

    final btnAddToCart = _AddToCartButton(article: article);
    
    return Column(
      children: [
        PhotoSection(article: article),
        title,
        SizedBox(height: 5.0),
        rating,
        SizedBox(height: 5.0,),
        price,
        FullEcoIndicator(
          ecoIndicator: article.form.getIndicator(),
        ),
        SizedBox(height: 15.0),
        storeText,
        SizedBox(height: 20.0),
        btnAddToCart,
        SizedBox(height: 15.0,),
        Divider(thickness: 1,),
        DescriptionSection(article: article),
        Divider(thickness: 1,),
        EcoDetailSection(article: article),
        Divider(thickness: 1,),
        StoreDescriptionSection(article: article),
        Divider(thickness: 1,),
        QuestionsSection(article: article)
      ]
    );
  }
}

class _AddToCartButton extends StatefulWidget {
  const _AddToCartButton({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  __AddToCartButtonState createState() => __AddToCartButtonState();
}

class __AddToCartButtonState extends State<_AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: FutureBuilder(
        future: cartBloc.articleExistsInCart(widget.article),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done: 
              return NormalButton(
                text: !snapshot.data!? 'Agregar al Carrito' : 'Ver en carrito',
                color: !snapshot.data!? EcoAppColors.MAIN_COLOR : Colors.lightGreen.shade50,
                textColor: !snapshot.data!? Colors.white : EcoAppColors.MAIN_COLOR,
                onPressed: () async {
                  !snapshot.data!? await _addToCart(context) : _goToCartView(context);
                  setState(() {});
                }
              );
            default: return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  Future<void> _addToCart(BuildContext context) async {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final result = await cartBloc.addArticleToCart(widget.article);
    if(result != null){
      print(result.id);
      print(result.articleId);
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Producto añadido al carrito'),
      backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      action: SnackBarAction(
        label: 'Ver carrito',
        onPressed: () => _goToCartView(context),
        textColor: EcoAppColors.ACCENT_COLOR,
      ),
    ));  

    cartBloc.loadCart();
  }

  void _goToCartView(BuildContext context){
    final appBloc = BlocProvider.of<AppBloc>(context);
    Navigator.popUntil(context, ModalRoute.withName('/'));
    appBloc.mainEcoNavBar.onTap(1);
  }
}

