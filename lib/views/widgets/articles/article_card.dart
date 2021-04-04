import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = Image(
      image: NetworkImage('https://picsum.photos/500/300'),
      height: 120,
      width: 140,
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

    final favorite = IconButton(
      icon: Icon(Icons.favorite_outline), 
      onPressed: (){}
    );

    final firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Text(
            'Título largo sdfsdf sdf sdf sdf  sdfs df',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.left,
            maxLines: 3,
          ),
        ),
        favorite
      ],
    );

    final secondRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          '\$ 30.000'
        ),
        Text(
          '80%'
        )
      ],
    );

    var expanded = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          firstRow,
          secondRow
        ],
      ),
    );
    final column = expanded;

    final card = Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          imageContainer,
          column
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0
      ),
      child: card,
    );
  }
}