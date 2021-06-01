import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_cover.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
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
            _QuestionsList(article: article.rating)
          ],
        ),
      ),
    );
  }

}

class _QuestionsList extends StatelessWidget {
  const _QuestionsList({
    Key? key,
    required this.elements, 
    required this.forEachElementWidget
  }) : super(key: key);

  final List<BaseModel> elements;
  final Widget Function(BaseModel) forEachElementWidget;

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];

    elements.forEach((element) { 
      content.addAll([forEachElementWidget(element), Divider(thickness: 1,)]);
    });

    return Column(
      children: content
    );
  }
}

class _QuestionTile extends StatelessWidget {
  const _QuestionTile({
    Key? key,
    required this.question,
  }) : super(key: key);

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final answer = question.answer != null
      ? Container(
          margin: EdgeInsets.only(
            left: 30.0,
            top: 10.0,
          ),
          child: Text(
          question.answer!.answer,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w300
          ),
        ),
      )
      : Container();

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  question.question,
                  style: GoogleFonts.montserrat(),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                '${question.date.day}/${question.date.month}/${question.date.year}',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300
                ),
              )
            ],
          ),
          answer,
        ],
      ),
    );
  }
}



