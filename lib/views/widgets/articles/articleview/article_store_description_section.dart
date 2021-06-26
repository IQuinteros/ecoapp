import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/store_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreDescriptionSection extends StatelessWidget {
  const StoreDescriptionSection({
    Key? key,
    required this.article,
    required this.store
  }) : super(key: key);

  final ArticleModel article;
  final StoreModel store;

  @override
  Widget build(BuildContext context) {

    store.tag = 'article-description';
    print('STORE DESCRP: $store');

    final storeLogo = Column(
      children: [
        Hero(
          tag: store.tag,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, 3),
                  blurRadius: 3.0,
                  spreadRadius: 0.0
                )
              ]
            ),
            height: 80.0,
            width: 80.0,
            child: Image(
              image: NetworkImage(store.photoUrl),
              fit: BoxFit.cover
            ),
          ),
        ),
        SizedBox(height: 15.0,),
        Text(
          store.publicName,
          style: GoogleFonts.montserrat(
            color: EcoAppColors.MAIN_DARK_COLOR
          ),
          textAlign: TextAlign.center,
        )
      ],
    );

    final storeInformation = ([bool alignCenter = false]) => Column(
      crossAxisAlignment: alignCenter? CrossAxisAlignment.center: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Información del vendedor',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
          textAlign: alignCenter? TextAlign.center : TextAlign.end
        ),
        SizedBox(height: 10.0),
        Text(
          'Media de reseña de clientes',
          style: GoogleFonts.montserrat(),
          textAlign: alignCenter? TextAlign.center : TextAlign.end
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: alignCenter? MainAxisAlignment.center : MainAxisAlignment.end,
          children: [
            Text(store.rating.avgRating.toStringAsPrecision(2), style: GoogleFonts.montserrat(), textAlign: TextAlign.end,), // TODO: Add rating view
            StarsRow(rating: store.rating.avgRating,)
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          '${store.location}, ${store.district.name}',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
          textAlign: alignCenter? TextAlign.center : TextAlign.end
        )
      ],
    );

    final content = ([bool expanded = true, bool alignCenter = false]) => [
      expanded? Expanded(child: storeLogo) : storeLogo,
      SizedBox(width: 20.0),
      expanded? Expanded(child: storeInformation(alignCenter), flex: 2) : storeInformation(alignCenter)
    ];

    final layoutBuilder = LayoutBuilder(
      builder: (context, constraints){
        print('Constraints: ${constraints.maxWidth}');
        if(MediaQuery.of(context).textScaleFactor > 1.35 || constraints.maxWidth <= 300){
          return Column(
            children: content(false, true),
          );
        }
        else{
          return Row(
            children: content(),
          );
        }
      }
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0
      ),
      child: Column(
        children: [
          layoutBuilder,
          SizedBox(height: 20.0),
          NormalButton(
            text: 'Ver más datos del vendedor', 
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (__) => StoreView(store: store)));
            }
          )
        ],
      ),
    );
  }
}