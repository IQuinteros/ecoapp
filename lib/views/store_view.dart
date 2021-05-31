import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:flutter_ecoapp/views/widgets/store/storeview/store_cover_section.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final StoreModel? store = ModalRoute.of(context)!.settings.arguments as StoreModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          store!.publicName,
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
          StoreCoverSection(store: store),
          Divider(thickness: 1,),
          SearchBar(),
          SizedBox(height: 20.0),
          EcoAppDebug.getArticleItems(initialId: 1)
        ],
      ),
    );
  }

}


