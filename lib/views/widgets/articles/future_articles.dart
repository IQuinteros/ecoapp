import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:google_fonts/google_fonts.dart';

class FutureArticles <T> extends StatefulWidget {
  const FutureArticles({
    Key? key,
    required this.notFoundMessage,
    required this.getFuture,
    this.recommended = false,
    this.onLongPress, 
    this.scrollController,
  }) : super(key: key);

  final String notFoundMessage;
  final Function(ArticleModel)? onLongPress;
  final bool recommended;
  final ScrollController? scrollController;
  final Future<List<ArticleModel>> Function(List<ArticleModel>) getFuture;

  @override
  _FutureArticlesState<T> createState() => _FutureArticlesState<T>();
}

class _FutureArticlesState<T> extends State<FutureArticles<T>> {

  List<ArticleModel> loadedArticles = [];

  bool refreshing = false;
  bool hasMoreArticles = false;

  @override
  void initState() { 
    super.initState();
    widget.scrollController?.addListener(() { 
      if(widget.scrollController == null) return;
      if(loadedArticles.length <= 0) return;
      if(widget.scrollController!.position.maxScrollExtent == 0){
        return;
      }
      if(widget.scrollController!.position.pixels >= widget.scrollController!.position.maxScrollExtent - 200){
        if(!refreshing && hasMoreArticles){
          setState(() {});
        }
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    
    return FutureBuilder(
      future: widget.getFuture(loadedArticles),
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.done:
            refreshing = false;
            if(!snapshot.hasData) return Container();
            loadedArticles.addAll(snapshot.data!);
            if(snapshot.data!.length <= 0) hasMoreArticles = false;
            else hasMoreArticles = true;
            if(loadedArticles.length <= 0) return Column(
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
                          widget.notFoundMessage,
                          style: GoogleFonts.montserrat(), 
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.recommended? Column(
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
                      getFuture: (loaded) => articleBloc.getArticlesFromSearch(
                        '', 
                        profile: profileBloc.currentProfile,
                        initial: 0,
                        quantity: 5
                      ), 
                      recommended: false
                    ),
                  ],
                ) : Container()
              ],
            );

            continue toDefault;
          case ConnectionState.waiting:
            refreshing = true;
            continue toDefault;
          toDefault:
          default: 
            if(loadedArticles.length <= 0) return LinearProgressIndicator();
            final listView = ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: loadedArticles.length,
              itemBuilder: (BuildContext context, int index){
                return ArticleCard(
                  article: loadedArticles[index],
                  onLongPress: () => widget.onLongPress?.call(loadedArticles[index]),
                  extraTag: UniqueKey().toString(),
                );
              },
              shrinkWrap: true,
            );

            final refreshingLoading = Container(
              margin: EdgeInsets.only(
                top: 20.0
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

            return Column(
              children: [
                listView,
                refreshing? refreshingLoading : Container()
              ],
            );
        }
      },
    );
  }
}