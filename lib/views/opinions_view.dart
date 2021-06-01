import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_cover.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/eco_items_list.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

class OpinionsView extends StatelessWidget {

  final ArticleModel article;

  const OpinionsView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Opiniones del producto',
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
            ArticleCover(
              article: article,
              subtitle: '${article.rating.count.toString()} opiniones',
            ),
            SizedBox(height: 10.0,),
            Divider(thickness: 1,),
            EcoItemsList<OpinionModel>(
              elements: article.rating.opinions,
              forEachElementWidget: (value) => _OpinionTile(opinion: value,)
            )
          ],
        ),
      ),
    );
  }

}

class _OpinionTile extends StatelessWidget {
  const _OpinionTile({
    Key? key,
    required this.opinion,
  }) : super(key: key);

  final OpinionModel opinion;

  @override
  Widget build(BuildContext context) {
    final comment = Container(
        margin: EdgeInsets.only(
          top: 10.0,
        ),
        child: Text(
        opinion.content.isNotEmpty? opinion.content : 'No incluyó comentario',
        style: GoogleFonts.montserrat(
          fontWeight: opinion.content.isNotEmpty? FontWeight.w300 : FontWeight.w200,
          fontStyle: opinion.content.isEmpty? FontStyle.italic : null,
        ),
        textAlign: TextAlign.start,
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StarsRow(rating: opinion.rating.toDouble()),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  opinion.title,
                  style: GoogleFonts.montserrat(),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                '${opinion.date.day}/${opinion.date.month}/${opinion.date.year}',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300
                ),
              )
            ],
          ),
          comment,
        ],
      ),
    );
  }
}



