import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreDescriptionSection extends StatelessWidget {
  const StoreDescriptionSection({
    Key key,
    @required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    StoreModel store = article.store;

    final storeLogo = Column(
      children: [
        Container(
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
        SizedBox(height: 15.0,),
        Text(
          store.publicName,
          style: GoogleFonts.montserrat(
            color: EcoAppColors.MAIN_COLOR
          ),
        )
      ],
    );

    final storeInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Información del vendedor',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Media de reseña de clientes',
          style: GoogleFonts.montserrat()
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('4.2', style: GoogleFonts.montserrat(),),
            StarsRow(rating: 2,)
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          '${store.location}, ${store.district?.name}',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );

    final rowContent = Row(
      children: [
        storeLogo,
        SizedBox(width: 20.0),
        Expanded(child: storeInformation)
      ],
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0
      ),
      child: Column(
        children: [
          rowContent,
          SizedBox(height: 20.0),
          NormalButton(
            text: 'Ver más datos del vendedor', 
            onPressed: (){
              Navigator.pushNamed(context, 'store', arguments: article.store);
            }
          )
        ],
      ),
    );
  }
}