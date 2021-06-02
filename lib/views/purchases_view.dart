import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/purchases/purchase_card.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';

class PurchasesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: getContent(context)),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
          onTap: (value){
        },
      )
    );
  }

  Widget getContent(BuildContext context){
    List<PurchaseModel> purchases = EcoAppDebug.purchases;

    final content = Column(
      children: [
        SearchBar(),
        EcoAppTextStyle.getTitle(
          'Mis compras',
          leftButton: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded),
            color: EcoAppColors.MAIN_COLOR,
            iconSize: 40,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        PurchaseCard(
          purchase: purchases[0]
        ),
        PurchaseCard(
          purchase: purchases[1]
        )
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }
}
