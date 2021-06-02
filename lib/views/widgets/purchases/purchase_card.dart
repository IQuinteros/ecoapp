import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/article_view.dart';
import 'package:flutter_ecoapp/views/widgets/articles/favorite_button.dart';
import 'package:flutter_ecoapp/views/widgets/articles/mini_eco_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseCard extends StatefulWidget {
  final PurchaseModel purchase;

  const PurchaseCard({Key? key, required this.purchase}) : super(key: key);

  @override
  _PurchaseCardState createState() => _PurchaseCardState();
}

class _PurchaseCardState extends State<PurchaseCard> {

  double blurRadius = 2.0;
  double shadowOpacity = 0.20;
  @override
  Widget build(BuildContext context) {
    PurchaseModel purchase = widget.purchase;

    return Container(
      child: Column(
        children: [
          Text(
            '$'
          )
        ],
      )
    );
  }


}