import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:google_fonts/google_fonts.dart';

class FutureArticles <T> extends StatelessWidget {
  const FutureArticles({
    Key? key,
    required this.notFoundMessage,
    required this.future,
    this.recommended = false,
    this.onLongPress
  }) : super(key: key);

  final String notFoundMessage;
  final Future<List<ArticleModel>> future;
  final Function(ArticleModel)? onLongPress;
  final bool recommended;

  @override
  Widget build(BuildContext context) {

    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.done:
            if(!snapshot.hasData) return Container();
            if(snapshot.data!.length <= 0) return Column(
              children: [
                Divider(thickness: 1,),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          notFoundMessage,
                          style: GoogleFonts.montserrat(), 
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                recommended? Column(
                  children: [
                    SizedBox(height: 10.0),
                    Divider(thickness: 1,),
                    SizedBox(height: 10.0),
                    Text(
                      'De todas formas, te recomendamos estos artículos',
                      style: GoogleFonts.montserrat(),
                    ),
                    SizedBox(height: 20.0),
                    FutureArticles(
                      notFoundMessage: '', 
                      future: articleBloc.getArticlesFromSearch('', profile: profileBloc.currentProfile), 
                      recommended: false
                    ),
                  ],
                ) : Container()
              ],
            );

            return Column(
              children: snapshot.data!.map<ArticleCard>((e) => ArticleCard(
                article: e,
                onLongPress: () => onLongPress?.call(e),
                extraTag: UniqueKey().toString(),
              )).toList()
            );
          default: return LinearProgressIndicator();
        }
      },
    );
  }
}