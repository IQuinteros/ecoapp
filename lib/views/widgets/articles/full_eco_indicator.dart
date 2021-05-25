import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:tinycolor/tinycolor.dart';

class FullEcoIndicator extends StatelessWidget {
  final EcoIndicator ecoIndicator;

  const FullEcoIndicator({Key key, @required this.ecoIndicator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> circles = [];

    if(ecoIndicator.hasRecycledMaterials)
      circles.add(getCircle(Icons.inventory, EcoAppColors.BLUE_ACCENT_COLOR, darkenScale: 35));
    if(ecoIndicator.hasReusTips)
      circles.add(getCircle(Icons.list_alt_rounded, EcoAppColors.ACCENT_COLOR, darkenScale: 38));
    if(ecoIndicator.isRecyclableProduct)
      circles.add(getCircle(Icons.eco, EcoAppColors.MAIN_COLOR));

    if(circles.length <= 0)
      return Container();

    return Container(
      margin: EdgeInsets.only(
        top: 20.0
      ),
      child: Stack(
        children: [
          getLine(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: circles
          ),
        ],
      ),
    );
  }

  Widget getLine(BuildContext context){
    return Container(
      height: 65.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              height: 15.0,
              width: double.infinity,
              color: EcoAppColors.LEFT_BAR_COLOR,
            ),
          ),
        ]
      ),
    );
  }

  Widget getCircle(IconData icon, Color color, {int darkenScale = 21}){
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