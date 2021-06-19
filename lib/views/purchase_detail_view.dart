import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/chat_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/purchase_bloc.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/chat_view.dart';
import 'package:flutter_ecoapp/views/opinions_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseDetailView extends StatelessWidget {
  final PurchaseModel purchase;

  const PurchaseDetailView({Key? key, required this.purchase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: getContent(context)),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
        onTap: (value){
          Navigator.pop(context, value);
        },
        unselected: true,
      )
    );
  }

  Widget getContent(BuildContext context){
    List<Widget> storeSections = [];
    purchase.storeSortedArticles.forEach((key, value) => storeSections.add(_StoreList(store: key, articles: value, purchase: purchase,)));

    final content = Column(
      children: [
        //SearchBar(),
        EcoTitle(
          text: 'Compra #${purchase.id}',
          leftButton: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded),
            color: EcoAppColors.MAIN_COLOR,
            iconSize: 40,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        Divider(thickness: 1,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: storeSections
        ),
        Divider(thickness: 1),
        _SummaryItem(purchase: purchase)
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  final PurchaseModel purchase;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Total: ${purchase.total}',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 18
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                              child: Text(
                  '${purchase.realTotal}',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text(
            'Descuento: ${purchase.discount.toStringAsFixed(1)}%',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            'Fecha de compra: ${purchase.createdDate.day}/${purchase.createdDate.month}/${purchase.createdDate.year}',
            style: GoogleFonts.montserrat(),
          ),
          // TODO: Check requirements
        ],
      ),
    );
  }
}

class _StoreList extends StatelessWidget {
  const _StoreList({
    Key? key,
    required this.store,
    required this.articles,
    required this.purchase
  }) : super(key: key);

  final StoreModel? store;
  final List<ArticleToPurchase> articles;
  final PurchaseModel purchase;

  @override
  Widget build(BuildContext context) {

    final chatBloc = BlocProvider.of<ChatBloc>(context);

    List<Widget> articlesToDisplay = articles.map<Widget>((e) => ArticleCard.fromPurchase(
      article: e.article,
      ecoIndicator: e.form.getIndicator(),
      price: e.unitPrice.toDouble(),
      title: e.title,
      extraTag: 'purchase-list-${e.id}',
      onLongPress: (){
        if(e.article != null){
          showModalBottomSheet(
            context: context, 
            builder: (BuildContext context){
              return _ModalArticleOptions(articlePurchase: e);
            }
          );
        }
        else {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Artículo no encontrado'),
            backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
          ));
        }
      },
    )).toList();

    Function()? onTap;
    if(store != null)
      onTap = () => Navigator.pushNamed(context, 'store', arguments: store);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 5.0
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 5.0
                    ),
                    child: Text(
                      store != null? store!.publicName : 'Otras tiendas',
                      style: GoogleFonts.montserrat(
                        color: store != null? EcoAppColors.MAIN_COLOR : Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                store != null? FutureBuilder(
                  future: chatBloc.getChatFromPurchase(purchase),
                  builder: (context, AsyncSnapshot<ChatModel?> snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.done:
                        return IconButton(
                          icon: Icon(
                            Icons.sms_rounded,
                            color: EcoAppColors.MAIN_COLOR,
                          ), 
                          onPressed: () => Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (__) => ChatView(
                                  chat: snapshot.data,
                                  store: snapshot.data != null? null : store,
                                  purchase: snapshot.data != null? null : purchase,
                                )
                              )
                          ) 
                        );
                      default: return CircularProgressIndicator();
                    }
                    
                  }
                ) : Container()
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            children: articlesToDisplay,
          )
        ],
      ),
    );
  }
}

class _ModalArticleOptions extends StatelessWidget {
  const _ModalArticleOptions({ Key? key, required this.articlePurchase }) : super(key: key);

  final ArticleToPurchase articlePurchase;

  @override
  Widget build(BuildContext context) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  articlePurchase.title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                  )
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Text(
              CurrencyUtil.formatToCurrencyString(articlePurchase.unitPrice, symbol: '\$') + ' x ${articlePurchase.quantity} unidades',
              style: GoogleFonts.montserrat()
            ),
            SizedBox(height: 20.0,),
            FutureBuilder(
              future: articleBloc.getOpinionsFromArticle(articlePurchase.article!, profileBloc.currentProfile),
              builder: (BuildContext context, AsyncSnapshot<List<OpinionModel>> snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.done:
                    bool found = snapshot.data!.length > 0;
                    return NormalButton(
                      text: found? 'Ver reseña' : 'Añadir reseña', 
                      onPressed: (){
                        if(found){
                          Navigator.push(context, MaterialPageRoute(builder: (__) => OpinionsView(article: articlePurchase.article!)));
                        }
                        else{
                          // TODO: New review
                        }
                      }
                    );
                  default: return Center(child: CircularProgressIndicator());
                }
                
              }
            ),
          ],
        ),
      ),
    );
  }
}
