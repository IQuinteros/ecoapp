import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/eco_cover.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:flutter_ecoapp/views/widgets/store/storeview/store_cover_section.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Chat',
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
      body: SafeArea(child: mainContent(context)),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
          onTap: (value){
        },
      )
    );
  }

  Widget mainContent(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          chatList()
        ],
      ),
    );
  }

  Widget chatList(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 3
          )
        ]
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5
      ),
      child: Column(
        children: [
          chatItem(ChatModel(id: 1, closed: false, createdDate: DateTime.now())),
          Divider(thickness: 1),
          chatItem(ChatModel(id: 1, closed: false, createdDate: DateTime.now()))
        ],
      ),
    );
  }

  Widget chatItem(ChatModel chat){
    final img = Container(
      height: 80,
      width: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5
          )
        ]
      ),
      child: Image(
        image: NetworkImage(chat.store.photoUrl),
        fit: BoxFit.cover,
      ),
    );

    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chat.store.publicName,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            chat.store.publicName,
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );

    final status = Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: EcoAppColors.RED_COLOR
      ),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => print('HOLA'),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0
        ),
        child: Row(
          children: [
            img,
            SizedBox(width: 15,),
            Expanded(child: info),
            status,
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }

}

