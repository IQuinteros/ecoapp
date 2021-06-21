import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/eco_cover.dart';
import 'package:flutter_ecoapp/views/widgets/eco_items_list.dart';
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
      body: mainContent(context),
    );
  }

  Widget mainContent(BuildContext context){
    ImageProvider<Object> imageData = AssetImage('assets/png/no-image.png');
    if(article.photos.length > 0) imageData = NetworkImage(article.photos[0].photoUrl);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0
        ),
        child: SafeArea(
          child: Column(
            children: [
              EcoCover(
                image: imageData,
                title: article.title,
                subtitle: '${article.questions.length.toString()} preguntas',
                size: 80
              ),
              SizedBox(height: 10.0,),
              Divider(thickness: 1,),
              EcoItemsList<QuestionModel>(
                elements: article.questions,
                forEachElementWidget: (value) => _QuestionTile(question: value),
              )
            ],
          ),
        ),
      ),
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
            textAlign: TextAlign.start,
          ),
        ) : Container();

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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



