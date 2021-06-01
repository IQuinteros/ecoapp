import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/store_rating_view.dart';
import 'package:flutter_ecoapp/views/widgets/eco_cover.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreCoverSection extends StatelessWidget {
  const StoreCoverSection({
    Key? key,
    required this.store,
  }) : super(key: key);

  final StoreModel store;

  @override
  Widget build(BuildContext context) {

    final description = Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0
      ),
      child: Text(
        store.description,
        style: GoogleFonts.montserrat(),
      )
    );

    final rating = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 60.0
      ),
      child: Column(
        children: [
          Text(
            'Media de valoraciones',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '4.2',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 15
                ),
              ),
              SizedBox(width: 20.0),
              StarsRow(rating: 4.2,)
            ],
          )
        ],
      ),
    );

    final ratingGesture = InkWell(
      child: rating,
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (__) => StoreRatingView(store: store)
        )
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      child: Column(
        children: [
          EcoCover(
            image: NetworkImage(store.photoUrl),
            title: '${store.location}, ${store.district.name}',
            subtitle: 'Ventas concretadas: 17.350',
            miniContent: 'Creado el ${store.createdDate.day}/${store.createdDate.month}/${store.createdDate.year}',
          ),
          SizedBox(height: 10.0),
          Divider(thickness: 1,),
          description,
          ratingGesture,
        ],
      ),
    );
  }
}