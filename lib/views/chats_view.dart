import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatsView extends StatelessWidget {

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
          _ChatList()
        ],
      ),
    );
  }

}

class _ChatList extends StatelessWidget {
  const _ChatList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          _ChatItem(chat: ChatModel(id: 1, closed: false, createdDate: DateTime.now())),
          Divider(thickness: 1),
          _ChatItem(chat: ChatModel(id: 1, closed: false, createdDate: DateTime.now()))
        ],
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  const _ChatItem({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final img = Container(
      height: 70,
      width: 70,
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
      onTap: () => print('HOLA'), // TODO: Navigate to Chat view
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

