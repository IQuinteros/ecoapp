import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/full_eco_indicator.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

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

    final storeText = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: Container(
        width: double.infinity,
        child: RichText(
          text: TextSpan(
            text: 'Vendido por ',
            style: TextStyle(
              color: Colors.black
            ),
            children: [
              TextSpan(
                text: '${article.store.publicName}',
                style: TextStyle(
                  color: EcoAppColors.MAIN_COLOR
                )
              )
            ]
          ),
        ),
      )
    );

    final btnAddToCart = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: NormalButton(
        text: 'Agregar al Carrito',
        onPressed: () {},
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
      ),
      SizedBox(height: 15.0),
      storeText,
      SizedBox(height: 20.0),
      btnAddToCart,
      SizedBox(height: 15.0,),
      Divider(thickness: 1,),
      getDescription(context, article),
      Divider(thickness: 1,),
      getEcoDetail(context, article),
      Divider(thickness: 1,),
      // TODO: Add store information
    ];
  }

  Widget getDescription(BuildContext context, ArticleModel article){
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descripción',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            article.description
          )
        ],
      )
    );
  }

  Widget getEcoDetail(BuildContext context, ArticleModel article){

    List<Widget> columnContent = [];
    
    if(article.form.hasDetail){
      if(article.form.getIndicator().hasRecycledMaterials){
        columnContent.add(getEcoTitle('Este producto contiene materiales reciclados y/o reutilizados'));
        columnContent.add(SizedBox(height: 10.0));
        columnContent.add(Text(article.form.recycledMatsDetail));
        columnContent.add(SizedBox(height: 20.0));
      }
      if(article.form.getIndicator().hasReuseTips){
        columnContent.add(getEcoTitle('¡Reutiliza! Estos son los tips del vendedor'));
        columnContent.add(SizedBox(height: 10.0));
        columnContent.add(Text(article.form.reuseTips));
        columnContent.add(SizedBox(height: 20.0));
      }
      if(article.form.getIndicator().isRecyclableProduct){
        columnContent.add(getEcoTitle('Este producto es reciclable'));
        columnContent.add(SizedBox(height: 10.0));
        columnContent.add(Text(article.form.recycledProdDetail));
        columnContent.add(SizedBox(height: 20.0));
      }
      columnContent.removeLast();
    }
    else{
      columnContent = [
        getEcoTitle('Producto amigable al entorno'),
        Text(
          article.form.generalDetail
        )
      ];
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnContent,
      )
    );
  }

  Widget getEcoTitle(String title){
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.eco,
            color: EcoAppColors.MAIN_COLOR
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}