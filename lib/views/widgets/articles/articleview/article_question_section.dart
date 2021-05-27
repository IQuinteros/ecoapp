import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSection extends StatelessWidget {
  const QuestionsSection({
    Key key,
    @required this.article,
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

    final question = Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Qué materiales tiene exactamente?',
                style: GoogleFonts.montserrat(),
              ),
              Text(
                '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
                style: GoogleFonts.montserrat(
                  color: Colors.black45
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.0,
              left: 20.0
            ),
            child: Text(
              'Contiene elementos extremadamente amigables al ecosistema como este, este y este otro, Saludos!',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );

    final questions = Column(
      children: [
        question,
        question
      ],
    );

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
            'Últimas preguntas',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 15
            ),
          ),
          SizedBox(height: 5.0),
          questions,
          SizedBox(height: 15.0),
          NormalButton(text: 'Ver más preguntas', onPressed: (){})
        ],
      ),
    );
  }
}
