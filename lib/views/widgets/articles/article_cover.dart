import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleCover extends StatelessWidget {
  const ArticleCover({
    Key? key,
    required this.article, 
    this.subtitle,
  }) : super(key: key);

  final ArticleModel article;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final img = article.photos.length > 0? Container(
      width: 80,
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: Image(
        image: NetworkImage(article.photos[0].photoUrl),
        fit: BoxFit.cover,
      ),
    ) : Container();
    
    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            article.title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 10.0,),
          Text(
            subtitle?? '',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.end,
          )
        ],
      ),
    );

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          img,
          SizedBox(width: 20.0),
          Expanded(child: info)
        ],
      ),
    );
  }
}