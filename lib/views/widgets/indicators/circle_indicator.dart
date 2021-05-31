import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinycolor/tinycolor.dart';

class CircleIndicator extends StatelessWidget {

  final IconData icon;
  final Color color;
  final int darkenScale;
  final String title;
  final String description;
  final bool canPress;

  const CircleIndicator({Key? key, required this.icon, required this.color, this.darkenScale = 21, this.title = 'Eco Amigable', this.description = '', this.canPress = true}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10.0,
            spreadRadius: 2.0
          )
        ],
        color: TinyColor.fromRGB(r: color.red, g: color.green, b: color.blue).darken(darkenScale).color.withOpacity(1),
        border: Border.all(
          color: color,
          width: 4.0
        ),
        shape: BoxShape.circle
      ),
      padding: EdgeInsets.all(2.0),
      child: IconButton(
        icon: Icon(icon, color: color,),
        color: color,
        iconSize: 40,
        onPressed: () => canPress? showIndicatorDialog(context) : null
      ),
    );
  }

  showIndicatorDialog(BuildContext context){

    final upContainer = Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: color
      ),
    );

    final content = [
      CircleIndicator(
        canPress: false,
        color: color,
        darkenScale: darkenScale,
        icon: icon,
        title: title
      ),
      SizedBox(height: 20.0,),
      Text(
        title,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500
        ),
      ),
      SizedBox(height: 20.0),
      Text(
        description
      ),
      Row(
        children: [
          Expanded(child: Container()),
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text(
              'Volver',
              textAlign: TextAlign.left,
            )
          ),
        ],
      )
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            upContainer,
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}