import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/views/login_view.dart';
import 'package:flutter_ecoapp/views/questions_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSection extends StatelessWidget {
  QuestionsSection({
    Key? key,
    required this.article,
    required this.onNewQuestion
  }) : super(key: key);

  final ArticleModel article;
  final _formKey = GlobalKey<FormState>();
  final Function() onNewQuestion;

  final TextEditingController questionController = TextEditingController();

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
      child: TextFormField(
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
        controller: questionController,
        onTap: (){
          // TODO: Open dialog
        },
        validator: (value) => value == null || value.isEmpty? 'Escribe la pregunta' : null,
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
          Form(key: _formKey, child: searchField),
          NormalButton(text: 'Enviar pregunta', onPressed: () => sendQuestion(context)),
          SizedBox(height: 20.0),
          Divider(thickness: 1,),
          SizedBox(height: 20.0,),
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
          haveQuestions? NormalButton(
            text: 'Ver más preguntas', 
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => QuestionsView(article: article,)))
          ) : Container()
        ],
      ),
    );
  }

  List<Widget> getQuestions(){
    List<Widget> questionsWidgets = [];
    article.questions.take(3).forEach((element) => questionsWidgets.add(_Question(question: element,)));
    return questionsWidgets;
  }

  void sendQuestion(BuildContext context) async {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    if(profileBloc.currentProfile == null){
      displayProfileMessage(context);
      return;
    }

    if(!_formKey.currentState!.validate()){
      return;
    }

    final result = await articleBloc.newQuestionToArticle(
      article: article, 
      profile: profileBloc.currentProfile!, 
      question: QuestionModel(
        id: 0, 
        question: questionController.text, 
        date: DateTime.now()
      )
    );

    if(result){
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pregunta enviada'),
        backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      ));
      onNewQuestion();
    }
    else{
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ha ocurrido un error inesperado'),
        backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      ));
    }
  }

  void displayProfileMessage(BuildContext context){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Debe iniciar sesión para enviar una pregunta'),
      backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      action: SnackBarAction(
        label: "Iniciar sesión",
        textColor: EcoAppColors.ACCENT_COLOR,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (__) => LoginView())),
      ),
    ));
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
