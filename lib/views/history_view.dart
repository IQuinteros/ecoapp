import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/history_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/history.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/future_articles.dart';
import 'package:flutter_ecoapp/views/widgets/index_app_bar.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        slivers: [
          IndexAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                getContent(context)
              ]
            ),
          )
        ],
      ),
      onRefresh: () => Future.delayed(Duration(milliseconds: 100), () => setState(() {})),
    );
  }

  Widget getContent(BuildContext context){
    

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EcoTitle(
          text: 'Mi Historial',
        ),
        HistorySection(scrollController: scrollController,)
      ],
    );

    return content;
  }
}

class HistorySection extends StatefulWidget {
  HistorySection({
    Key? key, this.scrollController,
  }) : super(key: key);

  final ScrollController? scrollController;

  @override
  _HistorySectionState createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    return FutureBuilder(
      future: userBloc.getLinkedUser(profileBloc.currentProfile),
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.done:
            return FutureArticles(
              notFoundMessage: 'No hay artículos en el historial', 
              getFuture: (loaded) => historyBloc.getHistory(
                user: snapshot.data!, 
                profile: profileBloc.currentProfile, 
                initial: loaded.length
              ),
              onLongPress: (e) => _askDelete(e),
              scrollController: widget.scrollController,
            );
          default: return LinearProgressIndicator();
        }
      },
    );
  }

  void _askDelete(ArticleModel article) {
    AwesomeDialog(
      title: 'Eliminar artículo del historial',
      desc: 'Se eliminará este artículo del historial. Aparecerá aquí denuevo si vuelves a visitar el mismo artículo',
      dialogType: DialogType.INFO, 
      animType: AnimType.BOTTOMSLIDE,
      context: context,
      btnOkText: 'Volver',
      btnCancelText: 'Eliminar',
      btnOkOnPress: () {},
      btnOkColor: Colors.black26,
      //btnCancelColor: Colors.black26,
      btnCancelOnPress: () => _deleteHistory(article),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
    )..show();
  }

  void _deleteHistory(ArticleModel article) async {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    final historyBloc = BlocProvider.of<HistoryBloc>(context);

    final user = await userBloc.getLinkedUser(profileBloc.currentProfile);
    if(user != null) await historyBloc.deleteHistory(article, user);

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Artículo eliminado del historial'),
      backgroundColor: EcoAppColors.LEFT_BAR_COLOR,
    ));
    setState(() {});
  }
}