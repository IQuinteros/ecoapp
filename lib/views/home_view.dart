import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/favorites.view.dart';
import 'package:flutter_ecoapp/views/history_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/future_articles.dart';
import 'package:flutter_ecoapp/views/widgets/categories/category_box.dart';
import 'package:flutter_ecoapp/views/widgets/categories/category_list_item.dart';
import 'package:flutter_ecoapp/views/widgets/home/featured_product.dart';
import 'package:flutter_ecoapp/views/widgets/index_app_bar.dart';

import 'package:flutter_ecoapp/views/widgets/mini_button.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';


class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: CustomScrollView(
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
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    final futureScrollable = FutureBuilder(
      future: articleBloc.getArticlesFromSearch("", profile: profileBloc.currentProfile),
      initialData: <ArticleModel>[],
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.done:
            if(!snapshot.hasData) return Icon(Icons.error);
            return Swiper(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index){
                try{
                  final product = FeaturedProduct(article: snapshot.data![index]);
                  return product;
                }catch(e, stacktrace){
                  print(e);
                  print(stacktrace);
                }
                return Container();
              },
              loop: false,
              viewportFraction: 0.9,
              scale: 0.9,
              autoplay: true,
              pagination: new SwiperPagination(
                builder: SwiperPagination.rect
              ),
            );
          default: return Center(child: CircularProgressIndicator());
        }
      },
    );

    final futureContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: 290.0,
      child: futureScrollable,
      margin: EdgeInsets.only(
        top: 20.0
      ),
    );

    final categoryRow = Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          CategoryBox(
            category: EcoAppDebug.getCategories()[0]
          ),
          CategoryBox(
            category: EcoAppDebug.getCategories()[1]
          ),
          CategoryBox(
            category: EcoAppDebug.getCategories()[2]
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
    
    final categoryView = LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > 490){
          return categoryRow;
        }
        else{
          return Column(
            children: [
              Divider(),
              CategoryListItem(
                category: EcoAppDebug.getCategories()[0],
              ),
              Divider(),
              CategoryListItem(
                category: EcoAppDebug.getCategories()[1]
              ),
              Divider(),
              CategoryListItem(
                category: EcoAppDebug.getCategories()[2]
              ),
              Divider(),
            ],
          );
        }
      }
    );

    final historyList = HistorySection();

    final favoriteList = FutureArticles(
      notFoundMessage: '', 
      getFuture: (loaded) => articleBloc.getArticlesFromSearch('', 
        profile: profileBloc.currentProfile,
        quantity: 5,
      ),
      clearOnRefresh: true,
    );

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EcoTitle(text: 'Productos Destacados'),
        futureContainer,
        EcoTitle(
          text: 'Categorías',
          rightButton: MiniButton(
            text: 'Ver mas',
            action: () => Navigator.pushNamed(context, 'categories'),
          )
        ),
        categoryView,
        EcoTitle(
          text: 'Novedades',
        ),
        favoriteList,
        EcoTitle(
          text: 'Historial',
          rightButton: MiniButton(
            text: 'Ver mas',
            action: (){},
          )
        ),
        historyList,
        SizedBox(height: 40.0)
      ],
    );

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }
}
