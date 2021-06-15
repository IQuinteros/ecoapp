import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
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
        unselected: true,
        onTap: (value){
          Navigator.pop(context, value);
        },
      )
    );
  }

  Widget getContent(BuildContext context){
    final articleBloc = BlocProvider.of<ArticleBloc>(context);

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
        FutureBuilder(
          future: articleBloc.getArticlesFromSearch(searching ?? ''),
          builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.done:
                if(!snapshot.hasData) return Container();
                if(snapshot.data!.length <= 0) return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0
                  ),
                  child: Text(
                    'No se han encontrado artículos sd afasdf asdf para tu búsqueda :c',
                    style: GoogleFonts.montserrat(), 
                  ),
                );

                return Column(
                  children: snapshot.data!.map<ArticleCard>((e) => ArticleCard(article: e)).toList()
                );
              default: return LinearProgressIndicator();
            }
          },
        )
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }

}