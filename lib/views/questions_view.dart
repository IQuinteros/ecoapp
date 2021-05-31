import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsView extends StatelessWidget {

  final ArticleModel article;

  const QuestionsView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Preguntas y respuestas',
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
            _QuestionsArticleCover(article: article),
            SizedBox(height: 10.0,),
            Divider(thickness: 1,),
            _QuestionsList(article: article)
          ],
        ),
      ),
    );
  }

}

class _QuestionsArticleCover extends StatelessWidget {
  const _QuestionsArticleCover({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final img = article.photos.length > 0? Container(
      width: 80,
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: Image(
        image: NetworkImage(article.photos[0].photoUrl),
        fit: BoxFit.cover,
      ),
    ) : Container();
    
    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            article.title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 10.0,),
          Text(
            '${article.questions!.length.toString()} preguntas',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.end,
          )
        ],
      ),
    );

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          img,
          SizedBox(width: 20.0),
          Expanded(child: info)
        ],
      ),
    );
  }
}

class _QuestionsList extends StatelessWidget {
  const _QuestionsList({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    List<QuestionModel> questions = article.questions!;
    List<Widget> content = [];

    questions.forEach((element) { 
      content.addAll([_QuestionTile(question: element), Divider(thickness: 1,)]);
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



