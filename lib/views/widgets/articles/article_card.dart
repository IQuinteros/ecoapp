import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/article_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/favorite_button.dart';
import 'package:flutter_ecoapp/views/widgets/articles/mini_eco_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleCard extends StatefulWidget {
  final ArticleModel? article;
  final String? title;
  final EcoIndicator? ecoIndicator;
  final double? price;

  final bool favorite;
  final String extraTag;

  const ArticleCard({Key? key, required this.article, this.favorite = false, this.ecoIndicator, this.price, this.title, this.extraTag = ''}) : super(key: key);

  const ArticleCard.fromPurchase({Key? key, this.article, this.favorite = false, required this.title, required this.ecoIndicator, required this.price, this.extraTag = ''}): super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {

  double blurRadius = 2.0;
  double shadowOpacity = 0.20;
  @override
  Widget build(BuildContext context) {

    if(widget.article != null)
      widget.article!.tag = 'article-card-${widget.extraTag}';
    
    ImageProvider<Object> imageData = AssetImage('assets/png/no-image.png');;
    if(widget.article != null)
      imageData = NetworkImage(widget.article!.photos[0].photoUrl);

    final image = Image(
      image: imageData,
      height: 120,
      width: 120,
      fit: BoxFit.cover,
    );

    Widget heroImage = image;

    if(widget.article != null)
      heroImage = Hero(
        tag: widget.article!.tag,
        child: image
      );

    final imageContainer = Container(
      child: heroImage,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .25),
            blurRadius: 5.0,
            spreadRadius: 5.0
          )
        ]
      ),
    );

    final firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Text(
            widget.title != null? widget.title! : widget.article!.title,
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.left,
            maxLines: 3,
          ),
        ),
        FavoriteButton(favorite: widget.favorite)
      ],
    );

    final ecoIndicator = MiniEcoIndicator(
      ecoIndicator: widget.ecoIndicator != null? widget.ecoIndicator! : widget.article!.form.getIndicator()
    );

    final secondRow = Container(
      margin: EdgeInsets.only(
        right: 15.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '\$ ' + CurrencyUtil.formatToCurrencyString(widget.price != null? widget.price!.round() : widget.article!.price.round()),
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          ecoIndicator,
        ],
      ),
    );

    var column = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 10.0),
          firstRow,
          SizedBox(height: 20),
          secondRow,
          SizedBox(width: 10.0)
        ],
      ),
    );

    // TODO: Add quantity
    final card = Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          imageContainer,
          SizedBox(width: 20.0),
          column,
          SizedBox(width: 10.0)
        ],
      ),
    );

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: blurRadius,
            spreadRadius: 2.0,
            color: Colors.black.withOpacity(shadowOpacity)
          ),
        ]
      ),
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 8.0
      ),
      child: InkWell(
        child: card,
        borderRadius: BorderRadius.circular(20.0),
        onTap: (){
          if(widget.article != null)
            Navigator.push(context, MaterialPageRoute(builder: (__) => ArticleView(article: widget.article!,)));
          else
          {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'El artículo no ha sido encontrado', // TODO: Open dialog with little information
                  style: GoogleFonts.montserrat(),
                ),
                backgroundColor: EcoAppColors.MAIN_COLOR,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        onHover: onHover
      ),
    );
  }

  onHover(val){
    setState(() {
      blurRadius = val? 15 : 2;
      shadowOpacity = val? 0.3 : 0.2;
    });
  }

}
