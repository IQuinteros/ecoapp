import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CartArticleCard extends StatefulWidget {
  final String title;
  final int price;
  final int percent;

  final bool favorite;

  const CartArticleCard({Key key, @required this.title, @required this.price, @required this.percent, this.favorite = false}) : super(key: key);

  @override
  _CartArticleCardState createState() => _CartArticleCardState();
}

class _CartArticleCardState extends State<CartArticleCard> {


  @override
  Widget build(BuildContext context) {
    final image = Image(
      image: NetworkImage('https://picsum.photos/500/300'),
      height: 120,
      width: 120,
      fit: BoxFit.cover,
    );

    final imageContainer = Container(
      child: image,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .25),
            blurRadius: 10.0,
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
            widget.title,
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.left,
            maxLines: 3,
          ),
        ),
      ],
    );

    final secondRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          '\$ ' + CurrencyUtil.formatToCurrencyString(widget.price),
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          widget.percent.toString() + '%',
          style: GoogleFonts.montserrat(
            color: EcoAppColors.MAIN_COLOR,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );

    var column = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 10.0),
          firstRow,
          SizedBox(height: 30),
          secondRow,
          SizedBox(width: 10.0)
        ],
      ),
    );

    final card = Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          imageContainer,
          SizedBox(width: 10.0),
          column,
          SizedBox(width: 10.0)
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0
      ),
      child: InkWell(
        child: card,
        borderRadius: BorderRadius.circular(20.0),
        onTap: (){},
      ),
    );
  }
}