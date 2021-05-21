import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedProduct extends StatefulWidget {

  final int price;
  final int percent;
  final String title;

  final String imageUrl;

  const FeaturedProduct({Key key, @required this.price, @required this.percent, @required this.title, @required this.imageUrl}) : super(key: key);

  @override
  _FeaturedProductState createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {

  @override
  Widget build(BuildContext context) {
    final image = Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 10.0,
            spreadRadius: 2.0,
            color: Color.fromRGBO(0, 0, 0, .25)
          )
        ]
      ),
      margin: EdgeInsets.only(
        bottom: 0.0
      ),
      child: Image(
        image: NetworkImage(widget.imageUrl),
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );

    final priceText = Text(
      '\$ ' + CurrencyUtil.formatToCurrencyString(widget.price), 
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w600
      ),
    );

    final percentText = Text(
      widget.percent.toString() + '%',
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w600
      ),
    );

    final titleText = Text(
      widget.title,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        
      ),
    );

    final card = Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                priceText,
                percentText
              ],
            ),
            SizedBox(height: 5.0),
            titleText
          ],
        ),
      ),
    );

    final locateCard = Positioned(
      top: 150,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 80),
              child: card,
            ),
          ],
        ),
      )
    );

    return Container(
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
        top: 10.0,
        bottom: 20.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {},
        child: Stack(
          children: [
            image,
            locateCard
          ],
        ),
      ),
    );
  }
}