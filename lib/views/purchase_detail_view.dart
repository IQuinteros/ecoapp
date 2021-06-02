import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/purchases/purchase_card.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
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
        },
      )
    );
  }

  Widget getContent(BuildContext context){
    List<Widget> storeSections = [];
    purchase.storeSortedArticles.forEach((key, value) => storeSections.add(getStoreList(key, value)));

    final content = Column(
      children: [
        SearchBar(),
        EcoAppTextStyle.getTitle(
          'Compra #${purchase.id}',
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
        )
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }

  Widget getStoreList(StoreModel? store, List<ArticleToPurchase> articles){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0
            ),
            child: Text(
              store != null? store.publicName : 'Otras tiendas',
              style: GoogleFonts.montserrat(
                color: store != null? EcoAppColors.MAIN_COLOR : Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ArticleCard(article: articles[0].article!) // TODO: Dynamic articles, with ArticlePurchase info
        ],
      ),
    );
  }
}
