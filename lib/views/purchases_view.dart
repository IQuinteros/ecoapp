import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/purchases/purchase_card.dart';

class PurchasesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: getContent(context)),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
        unselected: true,
        onTap: (value){
          Navigator.pop(context, value);
        },
      )
    );
  }

  Widget getContent(BuildContext context){
    List<PurchaseModel> purchases = EcoAppDebug.purchases; // Get purchases

    List<Widget> purchasesWidget = purchases.map<Widget>((e) => PurchaseCard(purchase: e)).toList();

    final content = Column(
      children: [
        //SearchBar(),
        EcoTitle(
          text: 'Mis compras',
          leftButton: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded),
            color: EcoAppColors.MAIN_COLOR,
            iconSize: 40,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        Column(children: purchasesWidget,)
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }
}
