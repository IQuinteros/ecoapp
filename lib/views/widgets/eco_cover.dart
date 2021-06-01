import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoCover extends StatelessWidget {
  const EcoCover({
    Key? key,
    required this.image,
    this.subtitle, 
    this.title, 
    this.miniContent,
    this.size = 100
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final String? miniContent;
  final ImageProvider<Object> image;
  final double size;

  @override
  Widget build(BuildContext context) {
    final imageContainer = Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5
          )
        ]
      ),
      child: Image(
        image: image,
        fit: BoxFit.cover,
      ),
    );

    List<Widget> tempContent = [];
    if(title != null && title!.isNotEmpty)
      tempContent.add(
        Text(
          title!,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
          textAlign: TextAlign.end,
        )
      );
    if(subtitle != null && subtitle!.isNotEmpty)
      tempContent.add(
        Text(
          subtitle!,
          style: GoogleFonts.montserrat(),
          textAlign: TextAlign.end,
        ),
      );
    if(miniContent != null && miniContent!.isNotEmpty)
      tempContent.add(
        Text(
          miniContent!,
          style: GoogleFonts.montserrat(),
          textAlign: TextAlign.end,
        )
      );

    List<Widget> infoContent = [];
    for(int i = 0; i < tempContent.length; i++){
      infoContent.add(tempContent[i]);
      if(i < tempContent.length - 1)
        infoContent.add(SizedBox(height: 10.0,));
    }

    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: infoContent
      ),
    );

    final firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        imageContainer,
        SizedBox(width: 20.0),
        Expanded(child: info)
      ],
    );

    return Container(
      child: firstRow,
    );
  }
}
