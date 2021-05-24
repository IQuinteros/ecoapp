import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/mini_eco_indicator.dart';
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

    final ecoIndicator = MiniEcoIndicator(
      ecoIndicator: EcoIndicator(
        hasRecycledMaterials: Random().nextBool(),
        hasReusTips: Random().nextBool(),
        isRecyclableProduct: Random().nextBool()
      ),
    );

    final secondRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        ecoIndicator,
        Text(
          '\$ ' + CurrencyUtil.formatToCurrencyString(widget.price),
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
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

    final rowFirst = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        imageContainer,
        SizedBox(width: 20.0),
        column,
        SizedBox(width: 10.0)
      ],
    );

    final deleteButton = TextButton(
      child: Text('Eliminar'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.black54),
        textStyle: MaterialStateProperty.all(GoogleFonts.montserrat())
      ),
      onPressed: () {},
    );

    final goStore = TextButton(
      child: Text('Ver tienda'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.black54),
        textStyle: MaterialStateProperty.all(GoogleFonts.montserrat())
      ),
      onPressed: () {},
    );

    final quantitySelector = DropdownButtonHideUnderline(
      child: DropdownButton(
        onChanged: (value){},
        style: GoogleFonts.montserrat(
          color: Colors.black
        ),
        value: 0,
        isExpanded: true,
        items: [
          DropdownMenuItem(
            child: Text('999'),
            value: 0,
          )
        ],
      )
    );

    final rowSecond = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(width: 20.0,),
        deleteButton,
        SizedBox(width: 10.0,),
        goStore,
        Expanded(child: SizedBox(), flex: 2,),
        Expanded(child: quantitySelector, flex: 1,),
        SizedBox(width: 20.0,),
      ],
    );

    final card = Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        children: [
          rowFirst,
          Divider(height: 0, thickness: 1, color: Colors.black12,),
          rowSecond,
        ],
      )
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