import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:google_fonts/google_fonts.dart';

class FutureArticles <T> extends StatelessWidget {
  const FutureArticles({
    Key? key,
    required this.notFoundMessage,
    required this.future,
    this.onLongPress
  }) : super(key: key);

  final String notFoundMessage;
  final Future<List<ArticleModel>> future;
  final Function(ArticleModel)? onLongPress;

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.done:
            if(!snapshot.hasData) return Container();
            if(snapshot.data!.length <= 0) return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  Text(
                    notFoundMessage,
                    style: GoogleFonts.montserrat(), 
                  ),
                  Spacer(),
                ],
              ),
            );

            return Column(
              children: snapshot.data!.map<ArticleCard>((e) => ArticleCard(
                article: e,
                onLongPress: () => onLongPress?.call(e),
              )).toList()
            );
          default: return LinearProgressIndicator();
        }
      },
    );
  }
}