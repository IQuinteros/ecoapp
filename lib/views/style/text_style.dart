import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoTitle extends StatelessWidget {
  const EcoTitle({
    Key? key,
    required this.text,
    this.rightButton,
    this.leftButton,
  }) : super(key: key);

  final String text;
  final Widget? rightButton;
  final Widget? leftButton;

  @override
  Widget build(BuildContext context) {
    final textWidget  = Container(child:Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.start,
      overflow: TextOverflow.fade,
    ));

    return Container(
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 20.0,
        bottom: 20.0
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          leftButton?? Container(),
          SizedBox(width: 15.0),
          Expanded(child: textWidget),
          rightButton?? Container()
        ],
      ),
    );
  }
}