import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/purchase_detail_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
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
      margin: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 10.0
          ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => PurchaseDetailView(purchase: purchase))),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.25)
              )
            ]
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.local_shipping_rounded,
                color: EcoAppColors.MAIN_DARK_COLOR,
                size: 40.0,
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${purchase.articles.length} artículos',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '${purchase.createdDate.day}/${purchase.createdDate.month}/${purchase.createdDate.year}',
                      style: GoogleFonts.montserrat(),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '\$' + CurrencyUtil.formatToCurrencyString(purchase.total.truncate()),
                            style: GoogleFonts.montserrat(
                              fontSize: 16
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        MiniEcoIndicator(ecoIndicator: purchase.summaryEcoIndicator)
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }


}