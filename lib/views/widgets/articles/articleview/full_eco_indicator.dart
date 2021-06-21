import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/indicators/circle_indicator.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FullEcoIndicator extends StatelessWidget {
  final EcoIndicator ecoIndicator;

  const FullEcoIndicator({Key? key, required this.ecoIndicator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> circles = [];

    if(ecoIndicator.hasRecycledMaterials)
      circles.add(
        CircleIndicator(
          icon: Icons.inventory, 
          color: EcoAppColors.BLUE_ACCENT_COLOR, 
          darkenScale: 35,
          title: 'Producto con materiales reciclados',
          description: 'Este producto fue creado a partir de materiales reciclados ya sea total o parcialmente. Con esto ayudas mucho al medio ambiente.',
        )
      );
    if(ecoIndicator.hasReuseTips)
      circles.add(
        CircleIndicator(
          icon:Icons.list_alt_rounded, 
          color: EcoAppColors.ACCENT_COLOR, 
          darkenScale: 38,
          title: '¡Hay tips de reutilización!',
          description: 'El vendedor incluyó tips de reutilización. Así, cuando creas que la vida útil de tu producto ha llegado a su fin, podrás reutilizar tu producto de otra forma, y así evitar desechar.',
        )
      );
    if(ecoIndicator.isRecyclableProduct)
      circles.add(
        CircleIndicator(
          icon: Icons.eco, 
          color: EcoAppColors.MAIN_COLOR,
          title: 'El producto es reciclable',
          description: 'Cuando el producto cumpla con su vida útil, este no será dañino al medio ambiente. Un gran apoyo a nuestro entorno.',
        )
      );

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
}