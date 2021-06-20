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

class ResultView extends StatefulWidget {

  final String? searching;

  const ResultView({Key? key, this.searching}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  final scrollController = ScrollController();
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
            vertical: 20.0,
            horizontal: 20.0
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  "Resultados de la búsqueda: '${widget.searching}'",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        FutureArticles(
          getFuture: (loaded) { print('LOADED: ${loaded.length}'); return articleBloc.getArticlesFromSearch(
            widget.searching ?? '', 
            profile: profileBloc.currentProfile,
            initial: loaded.length
          );}, 
          notFoundMessage: 'No se han encontrado artículos para tu búsqueda :c',
          recommended: true,
          scrollController: scrollController,
        )
      ],
    );

    return RefreshIndicator(
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        slivers: [
          IndexAppBar(searching: widget.searching,),
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
      ),
      onRefresh: () => Future.delayed(Duration(milliseconds: 100), () => setState(() {})),
    );

  }
}

