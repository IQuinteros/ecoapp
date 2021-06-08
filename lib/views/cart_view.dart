import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';

import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/mini_eco_indicator.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';


class CartView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(),
        EcoTitle(
          text: 'Carrito',
          rightButton: MiniEcoIndicator( // TODO: Only debug indicator
            ecoIndicator: EcoIndicator(
              hasRecycledMaterials: true,
              hasReuseTips: true,
              isRecyclableProduct: true
            ),
          ),
        ),
        EcoAppDebug.getCartArticleItems()
      ],
    );

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }
}