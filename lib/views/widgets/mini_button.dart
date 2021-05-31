import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniButton extends StatelessWidget {

  final String text;
  final Function()? action;

  const MiniButton({Key? key, required this.text, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: GoogleFonts.montserrat(),
      ),
      onPressed: action,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(EcoAppColors.MAIN_COLOR),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.all<Color>(EcoAppColors.ACCENT_COLOR),
        elevation: MaterialStateProperty.all<double>(2.0),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.0)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
      ),
    );
  }
}