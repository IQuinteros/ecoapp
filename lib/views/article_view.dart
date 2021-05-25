import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/full_eco_indicator.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';

class ArticleView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ArticleModel article = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: getContent(context, article),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
          onTap: (value){
        },
      )
    );
  }

  Widget getContent(BuildContext context, ArticleModel article){
    return CustomScrollView(
      slivers: [
        getAppBar(context, article),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              getMainContent(context, article)
            ]
          ),
        )
      ],
    );
  }

  Widget getAppBar(BuildContext context, ArticleModel article){
    print(article.tag);
    return SliverAppBar(
      elevation: 10.0,
      backgroundColor: EcoAppColors.MAIN_COLOR,
      foregroundColor: Colors.white,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: (){},
        ),
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          onPressed: (){},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: Hero(
          tag: article.tag,
          child: Image(
            image: NetworkImage(article.photos[0].photoUrl),
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }

  Widget getMainContent(BuildContext context, ArticleModel article){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20.0
          )
        ]
      ),
      margin: EdgeInsets.only(
        top: 20.0,
        left: 5.0,
        right: 5.0
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: getColumnContent(context, article),
        ),
        scrollDirection: Axis.vertical,
      )
    );
  }

  List<Widget> getColumnContent(BuildContext context, ArticleModel article){

    final title = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: Container(
        width: double.infinity,
        child: Text(
          article.title,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.left,
        ),
      ),
    );

    final rating = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: Row(
        children: [
          StarsRow(rating: 3.4),
          SizedBox(width: 10.0),
          Text(
            '4 opiniones'
          )
        ],
      ),
    );

    final price = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: Row(
        children: [
          Text(
            '\$ ' + CurrencyUtil.formatToCurrencyString(article.price.floor()),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(width: 30.0,),
          Text(
            '\$ ' + CurrencyUtil.formatToCurrencyString(article.price.floor()),
            style: TextStyle(
              decoration: TextDecoration.lineThrough
            ),
          ),
        ],
      ),
    );

    return [
      title,
      SizedBox(height: 5.0),
      rating,
      SizedBox(height: 15.0,),
      price,
      FullEcoIndicator(
        ecoIndicator: article.form.getIndicator(),
      )
    ];
  }
}