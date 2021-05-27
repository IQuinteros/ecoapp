import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class MiniEcoIndicator extends StatelessWidget {

  final EcoIndicator ecoIndicator;

  const MiniEcoIndicator({Key key, @required this.ecoIndicator}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Color> colors = [];
    if(ecoIndicator.hasRecycledMaterials)
      colors.add(EcoAppColors.BLUE_ACCENT_COLOR);
    if(ecoIndicator.hasReuseTips)
      colors.add(EcoAppColors.ACCENT_COLOR);
    if(ecoIndicator.isRecyclableProduct)
      colors.add(EcoAppColors.MAIN_COLOR);

    return Container(
      child: getStructure(colors)
    );
  }

  Widget getStructure(List<Color> colors){
    if(colors.length >= 3){
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getCircle(colors[0])
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getCircle(colors[1]),
              getCircle(colors[2])
            ],
          )
        ],
      );
    }
    else if(colors.length == 2){
      return Row(
        children: [
          getCircle(colors[0]),
          getCircle(colors[1])
        ],
      );
    }
    else if(colors.length == 1){
      return Center(
        child: getCircle(colors[0])
      );
    }
    else{
      return Container();
    }

  }

  Widget getCircle(Color color){
    return Icon(
      Icons.circle,
      size: 10,
      color: color,
    );
  }
}