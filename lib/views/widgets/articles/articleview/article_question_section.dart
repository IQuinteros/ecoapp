import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/views/questions_view.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSection extends StatelessWidget {
  const QuestionsSection({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final searchField = Container(
      margin: EdgeInsets.symmetric(
        vertical: 15.0
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        style: GoogleFonts.montserrat(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: 'Pregunta al vendedor',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0
          ),
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14
          )
        ),
        readOnly: false,
        onTap: (){
          // TODO: Open dialog
        },
      ),
    );

    final questions = Column(
      children: getQuestions()
    );

    bool haveQuestions = article.questions.length > 0;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preguntas y respuestas',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 16
            ),
          ),
          searchField,
          Text(
            haveQuestions? 
              'Últimas preguntas' : 'Aún no hay preguntas',
            style: GoogleFonts.montserrat(
              fontWeight: haveQuestions? FontWeight.w500 : FontWeight.w300,
              fontSize: haveQuestions? 15 : 14
            ),
          ),
          SizedBox(height: 5.0),
          questions,
          SizedBox(height: 15.0),
          NormalButton(
            text: 'Ver más preguntas', 
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QuestionsView(article: article,)))
          )
        ],
      ),
    );
  }

  List<Widget> getQuestions(){
    List<Widget> questionsWidgets = [];
    article.questions.take(3).forEach((element) => questionsWidgets.add(_Question(question: element,)));
    return questionsWidgets;
  }
}

class _Question extends StatelessWidget {
  const _Question({
    Key? key,
    required this.question
  }) : super(key: key);

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    bool hasAnswer = question.answer != null && question.answer!.answer.isNotEmpty;

    final answerContainer = hasAnswer?
      Container(
        margin: EdgeInsets.only(
          top: 10.0,
          left: 20.0
        ),
        child: Text(
          question.answer!.answer,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w300,
          ),
        ),
      )
      : Container();

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  question.question,
                  style: GoogleFonts.montserrat(),
                ),
              ),
              Text(
                '${question.date.day.toString()}/${question.date.month.toString()}/${question.date.year.toString()}',
                style: GoogleFonts.montserrat(
                  color: Colors.black45
                ),
              )
            ],
          ),
          answerContainer
        ],
      ),
    );
  }
}
