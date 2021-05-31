import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/store.dart';
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
    final image = Hero(
      tag: store.tag,
      child: Container(
        width: 100,
        height: 100,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5
            )
          ]
        ),
        child: Image(
          image: NetworkImage(store.photoUrl),
          fit: BoxFit.cover,
        ),
      ),
    );

    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${store.location}, ${store.district.name}',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 10.0),
          Text(
            'Ventas concretadas: 17.350',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 10.0),
          Text(
            'Creado el ${store.createdDate.day}/${store.createdDate.month}/${store.createdDate.year}',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.end,
          )
        ],
      ),
    );

    final firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        image,
        SizedBox(width: 20.0),
        Expanded(child: info)
      ],
    );

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

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      child: Column(
        children: [
          firstRow,
          SizedBox(height: 10.0),
          Divider(thickness: 1,),
          description,
          rating,
        ],
      ),
    );
  }
}