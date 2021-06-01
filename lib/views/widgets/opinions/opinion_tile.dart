import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

class OpinionTile extends StatelessWidget {
  const OpinionTile({
    Key? key,
    required this.opinion, 
    this.displayArticle = false,
  }) : super(key: key);

  final OpinionModel opinion;
  final bool displayArticle;

  @override
  Widget build(BuildContext context) {
    final comment = Container(
        margin: EdgeInsets.only(
          top: 10.0,
        ),
        child: Text(
        opinion.content.isNotEmpty? opinion.content : 'No incluyó comentario',
        style: GoogleFonts.montserrat(
          fontWeight: opinion.content.isNotEmpty? FontWeight.w300 : FontWeight.w200,
          fontStyle: opinion.content.isEmpty? FontStyle.italic : null,
        ),
        textAlign: TextAlign.start,
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StarsRow(rating: opinion.rating.toDouble()),
              displayArticle? InkWell(
                onTap: () => print(opinion.article.title), // TODO: Navigate to article
                child: Text(
                  'Ver artículo',
                  style: GoogleFonts.montserrat(
                    color: EcoAppColors.MAIN_COLOR
                  ),
                ),
              ) : Container()
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  opinion.title,
                  style: GoogleFonts.montserrat(),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                '${opinion.date.day}/${opinion.date.month}/${opinion.date.year}',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300
                ),
              )
            ],
          ),
          comment,
        ],
      ),
    );
  }
}