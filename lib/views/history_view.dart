import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/history_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/history.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    
    final historyBloc = BlocProvider.of<HistoryBloc>(context);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SearchBar(),
        EcoTitle(
          text: 'Mi Historial',
        ),
        FutureBuilder(
          future: userBloc.getLinkedUser(profileBloc.currentProfile),
          builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.done:
                return FutureBuilder(
                  future: historyBloc.getHistory(user: snapshot.data!),
                  builder: (context, AsyncSnapshot<List<ArticleModel>> snapshot) {
                    if(!snapshot.hasData) return Container();
                    switch(snapshot.connectionState){
                      case ConnectionState.done:
                        if(snapshot.data!.length <= 0) return Column(
                          children: [
                            Divider(thickness: 1,),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 20.0
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Spacer(),
                                  Text(
                                    'No hay artículos en el historial',
                                    style: GoogleFonts.montserrat(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ],
                        );
                        return Column(
                          children: snapshot.data!.map<Widget>((e) => ArticleCard(article: e)).toList(),
                        );
                      default: return LinearProgressIndicator();
                    }
                  },
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