import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesView extends StatelessWidget {
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
    final content = Column(
      children: [
        SearchBar(),
        EcoAppTextStyle.getTitle(
          'Categorías',
        ),
        getTile(
          context,
          category: CategoryModel(id: 1, title: 'Hogar', createdDate: DateTime.now())
        ),
        SizedBox(height: 20),
        getTile(
          context,
          category: CategoryModel(id: 1, title: 'Cuidado personal', createdDate: DateTime.now())
        ),
        SizedBox(height: 20),
        getTile(
          context,
          category: CategoryModel(id: 1, title: 'Alimentos', createdDate: DateTime.now())
        ),
        //EcoAppDebug.getArticleItems()
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }

  Widget getTile(BuildContext context, {required CategoryModel category}){
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 2
          )
        ]
      ),
      child: ListTile(
        onTap: () {},   
        leading: Icon(
          category.getIcon(),
          color: EcoAppColors.MAIN_COLOR,
          size: 30,
        ),
        title: Text(
          category.title,
          style: GoogleFonts.montserrat(),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right_rounded,
          color: EcoAppColors.MAIN_COLOR,
          size: 40,
        ),
      ),
    );
  }
}