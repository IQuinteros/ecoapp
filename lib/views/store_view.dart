import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/future_articles.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:flutter_ecoapp/views/widgets/store/storeview/store_cover_section.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreView extends StatelessWidget {

  final StoreModel store;

  const StoreView({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          store.publicName,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded),
          color: EcoAppColors.MAIN_COLOR,
          iconSize: 40,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: mainContent(context, store),
    );
  }

  Widget mainContent(BuildContext context, StoreModel store){
    final articleBloc = BlocProvider.of<ArticleBloc>(context);

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            StoreCoverSection(store: store),
            Divider(thickness: 1,),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0
              ),
              child: SearchBar(
                storeFilter: store,
              )
            ),
            SizedBox(height: 20.0),
            FutureArticles(
              notFoundMessage: 'La tienda aún no tiene artículos publicados', 
              getFuture: (loaded) =>  articleBloc.getArticlesOfStore(store),
              clearOnRefresh: true,
            )
          ],
        ),
      ),
    );
  }

}

