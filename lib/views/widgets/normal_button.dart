import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Widget leading;
  final Function onPressed;

  const NormalButton({Key key, @required this.text, this.color = EcoAppColors.MAIN_COLOR, this.textColor = Colors.white, @required this.onPressed, this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading?? Container(),
              leading != null? SizedBox(width: 10.0) : Container(),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.montserrat(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(4.0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          backgroundColor: MaterialStateProperty.all(color),
          foregroundColor: MaterialStateProperty.all(textColor)
        ),
        onPressed: onPressed,
      ),
    );
  }
}