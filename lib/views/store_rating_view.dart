import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_cover.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/eco_items_list.dart';
import 'package:flutter_ecoapp/views/widgets/opinions/opinion_tile.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreRatingView extends StatelessWidget {

  final StoreModel store;

  const StoreRatingView({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Valoración de clientes',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded),
          color: EcoAppColors.MAIN_COLOR,
          iconSize: 40,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(child: mainContent(context)),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
          onTap: (value){
        },
      )
    );
  }

  Widget mainContent(BuildContext context){

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0
        ),
        child: Column(
          children: [
            _StoreCover(
              store: store,
              title: store.publicName,
              subtitle: '${store.location}, ${store.district}',
              miniContent: 'x valoraciones',
            ),
            SizedBox(height: 10.0,),
            Divider(thickness: 1,),
             EcoItemsList<OpinionModel>(
              elements: store.allOpinions,
              forEachElementWidget: (value) => OpinionTile(opinion: value, displayArticle: true)
            ) 
          ],
        ),
      ),
    );
  }

}

class _StoreCover extends StatelessWidget {
  const _StoreCover({
    Key? key,
    required this.store, 
    this.subtitle, this.title, this.miniContent,
  }) : super(key: key);

  final StoreModel store;
  final String? title;
  final String? subtitle;
  final String? miniContent;

  @override
  Widget build(BuildContext context) {
    final image = Container(
      width: 100,
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5
          )
        ]
      ),
      child: Image(
        image: NetworkImage(store.photoUrl),
        fit: BoxFit.cover,
      ),
    );

    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title?? '',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 10.0),
          Text(
            subtitle?? '',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 10.0),
          Text(
            miniContent?? '',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.end,
          )
        ],
      ),
    );

    final firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        image,
        SizedBox(width: 20.0),
        Expanded(child: info)
      ],
    );

    return Container(
      child: firstRow,
    );
  }
}

