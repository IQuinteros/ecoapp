import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoAppTextStyle{

  static TextStyle TITLE_STYLE = GoogleFonts.montserrat(
    fontSize: 25,
    fontWeight: FontWeight.bold
  );

  static Widget getTitle(String text, {Widget rightButton}){
    final textWidget  = Flexible(child:Text(
      text,
      style: TITLE_STYLE,
      textAlign: TextAlign.start,
      overflow: TextOverflow.fade,
    ));

    return Container(
      margin: EdgeInsets.only(
        left: 30.0,
        right: 15.0,
        top: 20.0,
        bottom: 20.0
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget,
          rightButton?? Container()
        ],
      ),
    );
  }

}