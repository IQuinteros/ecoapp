import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/bloc/history_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/image_view.dart';
import 'package:flutter_ecoapp/views/opinions_view.dart';
import 'package:flutter_ecoapp/views/store_view.dart';
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

class ArticleView extends StatefulWidget {

  final ArticleModel? article;
  final int? articleId;

  const ArticleView({Key? key, required this.article, this.articleId}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  ArticleModel? refreshArticle;
  bool firstRefreshing = false;

  @override
  Widget build(BuildContext context) {
    if(refreshArticle == null) refreshArticle = widget.article;

    return Scaffold(
      body: getContent(context),
    );
  }

  Widget getContent(BuildContext context){
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    if(refreshArticle == null){
      if(!firstRefreshing){
        refreshView(context);
        firstRefreshing = true;
        return Center(child: CircularProgressIndicator(),);
      }else{
        return Center(child: Text(
          'No se ha podido cargar el artículo',
          style: GoogleFonts.montserrat(),
        ));
      }
    }

    userBloc.getLinkedUser(profileBloc.currentProfile).then((value) {
      if(value != null) historyBloc.addToHistory(user: value, article: refreshArticle!);
    });    

    return RefreshIndicator(
      child: CustomScrollView(
        slivers: [
          _ArticleAppBar(article: refreshArticle!),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _ArticleMainContent(
                  article: refreshArticle!,
                  onNewQuestion: () => refreshView(context),
                )
              ]
            ),
          )
        ],
      ),
      onRefresh: () => refreshView(context)
    );
  }

  Future<void> refreshView(BuildContext context) async { 
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    refreshArticle = await articleBloc.getArticleFromId(refreshArticle?.id ?? widget.articleId!);
    setState(() {});
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
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    return SliverAppBar(
      elevation: 10.0,
      backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      foregroundColor: Colors.white,
      expandedHeight: article.photos.length > 0? 250.0 : null,
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
        FavoriteButton(favorite: article.favorite, disabledColor: Colors.white,
          onChanged: (value){
            // Add favorite
            profileBloc.setFavoriteArticle(article, value, (ready) {});
          },
        )
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
      flexibleSpace: article.photos.length > 0? FlexibleSpaceBar(
        centerTitle: false,
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        background: GestureDetector(
          child: Hero( 
            tag: article.tag,
            child: Image(
              image: NetworkImage(article.photos.length > 0? article.photos[0].photoUrl : ''),
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            )
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => ImageView(photos: article.photos, title: article.title,))),
        ),
      ) : null,
    );
  }
}

class _ArticleMainContent extends StatelessWidget {
  const _ArticleMainContent({
    Key? key,
    required this.article,
    required this.onNewQuestion,
  }) : super(key: key);

  final ArticleModel article;
  final Function() onNewQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        left: 5.0,
        right: 5.0
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: SafeArea(
        child: _ArticleContent(article: article, onNewQuestion: onNewQuestion,),
        top: false,
      ),
    );
  }
}

class _ArticleContent extends StatelessWidget {

  _ArticleContent({
    Key? key,
    required this.article,
    required this.onNewQuestion,
  }) : super(key: key);

  final ArticleModel article;
  final Function() onNewQuestion;

  /// Session streams  
  final _storeController = StreamController<StoreModel?>.broadcast();

  Function(StoreModel?) get _storeSink => _storeController.sink.add;
  Stream<StoreModel?> get storeStream => _storeController.stream;

  void disposeStreams(){
    _storeController.close();
  }

  @override
  Widget build(BuildContext context) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);

    articleBloc.getStoreOfArticle(article).then((value) {
      _storeSink(value);
      disposeStreams();
    });

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
              article.rating.count > 0? '${article.rating.count} ${article.rating.count > 1? 'opiniones' : 'opinión'}' : 'Sin opiniones aún',
              style: GoogleFonts.montserrat(
                color: EcoAppColors.MAIN_COLOR
              ),
            )
          ],
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (__) => OpinionsView(article: article,))
        );
      }
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
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.push(context, MaterialPageRoute(builder: (__) => StoreView(store: article.store!)));
      },
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
                  text: article.store!.publicName,//'${article.store!.publicName}',
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
        StoreDescriptionSection(article: article, store: article.store!),
        Divider(thickness: 1,),
        QuestionsSection(article: article, onNewQuestion: onNewQuestion)
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
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
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

    cartBloc.loadCart(profile: profileBloc.currentProfile);
  }

  void _goToCartView(BuildContext context){
    final appBloc = BlocProvider.of<AppBloc>(context);
    Navigator.popUntil(context, ModalRoute.withName('/'));
    appBloc.mainEcoNavBar.onTap(1);
  }
}

