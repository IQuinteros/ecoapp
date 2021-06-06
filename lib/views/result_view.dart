import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultView extends StatelessWidget {

  final String? searching;

  const ResultView({Key? key, this.searching}) : super(key: key);

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
    final content = Column(
      children: [
        SearchBar(
          searching: searching,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  "Resultados de la búsqueda: '$searching'",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        EcoAppDebug.getArticleItems()
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }
}