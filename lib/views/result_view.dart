import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/future_articles.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/index_app_bar.dart';
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
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    final content = Column(
      children: [
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
        FutureArticles(
          future: articleBloc.getArticlesFromSearch(searching ?? '', profile: profileBloc.currentProfile), 
          notFoundMessage: 'No se han encontrado artículos para tu búsqueda :c',
          recommended: true,
        )
      ],
    );

    return CustomScrollView(
      slivers: [
        IndexAppBar(searching: searching,),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SingleChildScrollView(
                child: content,
                scrollDirection: Axis.vertical,
              )
            ]
          ),
        )
      ],
    );

  }

}

