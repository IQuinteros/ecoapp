import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/eco_cover.dart';
import 'package:flutter_ecoapp/views/widgets/eco_items_list.dart';
import 'package:flutter_ecoapp/views/widgets/opinions/opinion_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class OpinionsView extends StatelessWidget {

  final ArticleModel article;
  final bool profileOpinion;

  const OpinionsView({Key? key, required this.article, this.profileOpinion = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Opiniones del producto',
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
      body: mainContent(context),
    );
  }

  Widget mainContent(BuildContext context){
    ImageProvider<Object> imageData = AssetImage('assets/png/no-image.png');
    if(article.photos.length > 0) imageData = NetworkImage(article.photos[0].photoUrl);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0
        ),
        child: SafeArea(
          child: Column(
            children: [
              EcoCover(
                image: imageData,
                title: article.title,
                subtitle: profileOpinion? 'Tu reseña' : '${article.rating.count.toString()} opiniones',
                size: 80
              ),
              SizedBox(height: 10.0,),
              Divider(thickness: 1,),
              EcoItemsList<OpinionModel>(
                elements: article.rating.opinions,
                forEachElementWidget: (value) => OpinionTile(opinion: value,),
                noElementsText: 'No hay opiniones para mostrar',
              )
            ],
          ),
        ),
      ),
    );
  }

}

