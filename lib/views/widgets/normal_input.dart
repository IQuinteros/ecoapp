import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalInput extends StatelessWidget {
  const NormalInput({
    Key key,
    @required this.header,
    @required this.hint,
    @required this.icon, 
    this.readOnly = false, 
    this.onTap, 
    this.type = TextInputType.text,
  }) : super(key: key);

  final String header;
  final String hint;
  final IconData icon;
  final bool readOnly;
  final Function onTap;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.0
      ),
      child: TextField(
        keyboardType: type,
        style: GoogleFonts.montserrat(),
        readOnly: readOnly,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: header,
          prefixIcon: Icon(icon)
        ),
        onTap: onTap,
      ),
    );
  }
}
