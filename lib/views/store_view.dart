import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final StoreModel store = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          store.publicName,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded),
          color: EcoAppColors.MAIN_COLOR,
          iconSize: 40,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(child: mainContent(context, store)),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
          onTap: (value){
        },
      )
    );
  }

  Widget mainContent(BuildContext context, StoreModel store){
    return SingleChildScrollView(
      child: Column(
        children: [
          getCover(store),
          Divider(thickness: 1,),
          SearchBar(),
          SizedBox(height: 20.0),
          EcoAppDebug.getArticleItems(initialId: 1)
        ],
      ),
    );
  }

  Widget getCover(StoreModel store){
    final image = Container(
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
    );

    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${store.location}, ${store.district?.name}',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500
            )
          ),
          SizedBox(height: 10.0),
          Text(
            'Ventas concretadas: 17.350',
            style: GoogleFonts.montserrat(),
          ),
          SizedBox(height: 10.0),
          Text(
            'Creado el ${store.createdDate.day}/${store.createdDate.month}/${store.createdDate.year}',
            style: GoogleFonts.montserrat(),
          )
        ],
      ),
    );

    final firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        image,
        SizedBox(width: 20.0),
        info
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
          description,
          rating,
        ],
      ),
    );
  }

}
