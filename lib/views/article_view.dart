import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/store.dart';
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
      getPhotosSection(context, article),
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
      getStoreDescription(context, article),
      Divider(thickness: 1,),
      getQuestions(context, article)
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

  getStoreDescription(BuildContext context, ArticleModel article) {
    StoreModel store = article.store;

    final storeLogo = Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 3),
                blurRadius: 3.0,
                spreadRadius: 0.0
              )
            ]
          ),
          height: 80.0,
          width: 80.0,
          child: Image(
            image: NetworkImage(store.photoUrl),
            fit: BoxFit.cover
          ),
        ),
        SizedBox(height: 15.0,),
        Text(
          store.publicName,
          style: GoogleFonts.montserrat(
            color: EcoAppColors.MAIN_COLOR
          ),
        )
      ],
    );

    final storeInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Información del vendedor',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Media de reseña de clientes',
          style: GoogleFonts.montserrat()
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('4.2', style: GoogleFonts.montserrat(),),
            StarsRow(rating: 2,)
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          '${store.location}, ${store.district?.name}',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );

    final rowContent = Row(
      children: [
        storeLogo,
        SizedBox(width: 20.0),
        Expanded(child: storeInformation)
      ],
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0
      ),
      child: Column(
        children: [
          rowContent,
          SizedBox(height: 20.0),
          NormalButton(text: 'Ver más datos del vendedor', onPressed: (){})
        ],
      ),
    );
  }

  getQuestions(BuildContext context, ArticleModel article) {
    final searchField = Container(
      margin: EdgeInsets.symmetric(
        vertical: 15.0
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        style: GoogleFonts.montserrat(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: 'Pregunta al vendedor',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0
          ),
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14
          )
        ),
        readOnly: false,
        onTap: (){
          // TODO: Open dialog
        },
      ),
    );

    final question = Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Qué materiales tiene exactamente?',
                style: GoogleFonts.montserrat(),
              ),
              Text(
                '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
                style: GoogleFonts.montserrat(
                  color: Colors.black45
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.0,
              left: 20.0
            ),
            child: Text(
              'Contiene elementos extremadamente amigables al ecosistema como este, este y este otro, Saludos!',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300
              ),
            ),
          )
        ],
      ),
    );

    final questions = Column(
      children: [
        question,
        question
      ],
    );

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preguntas y respuestas',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 16
            ),
          ),
          searchField,
          Text(
            'Últimas preguntas',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 15
            ),
          ),
          SizedBox(height: 5.0),
          questions,
          SizedBox(height: 15.0),
          NormalButton(text: 'Ver más preguntas', onPressed: (){})
        ],
      ),
    );
  }

  getPhotosSection(BuildContext context, ArticleModel article) {
    final photo = GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          right: 10.0
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 1
            )
          ]
        ),
        child: Image(
          image: NetworkImage(article.photos[0].photoUrl),
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
      onTap: (){},
    );

    return Container(
      height: 100,
      margin: EdgeInsets.only(
        bottom: 10.0
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 20.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              photo,
              photo,
            ],
          ),
        ),
      ),
    );
  }
}