import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:tinycolor/tinycolor.dart';

class FullEcoIndicator extends StatelessWidget {
  final EcoIndicator ecoIndicator;

  const FullEcoIndicator({Key key, this.ecoIndicator}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
        top: 20.0
      ),
      child: Stack(
        children: [
          getLine(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getCircle(Icons.inventory, EcoAppColors.BLUE_ACCENT_COLOR, darkenScale: 35),
              getCircle(Icons.list_alt_rounded, EcoAppColors.ACCENT_COLOR, darkenScale: 38),
              getCircle(Icons.eco, EcoAppColors.MAIN_COLOR),
            ],
          ),
        ],
      ),
    );
  }

  Widget getLine(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Opacity(
        opacity: 0.3,
        child: Container(
          height: 15.0,
          width: double.infinity,
          color: EcoAppColors.LEFT_BAR_COLOR,
        ),
      ),
    );
  }

  Widget getCircle(IconData icon, Color color, {int darkenScale = 21}){
    return Container(
      decoration: BoxDecoration(
        color: TinyColor.fromRGB(r: color.red, g: color.green, b: color.blue).darken(darkenScale).color.withOpacity(1),
        border: Border.all(
          color: color,
          width: 4.0
        ),
        shape: BoxShape.circle
      ),
      padding: EdgeInsets.all(2.0),
      child: Ink(
        decoration: ShapeDecoration(
          color: color,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(icon, color: color,),
          color: color,
          iconSize: 40,
          onPressed: (){ print('hola');},
        ),
      )
    );
  }
}