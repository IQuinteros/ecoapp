import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatelessWidget {

  final ChatModel chat;

  ChatView({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.75),
        centerTitle: false,
        elevation: 5,
        title: Text(
          chat.store.publicName,
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
    List<MessageModel> messages = chat.messages;
    bool tempIsOwner = false;
    List<Widget> messagesWidget = messages.map<Widget>((e) { 
      Widget message = getMessage(
        content: Column(
          crossAxisAlignment: e.isOwner? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              e.message,
              style: GoogleFonts.montserrat(),
            ),
            SizedBox(height: 5,),
            Text(
              '${e.date.day}/${e.date.month}/${e.date.year}',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
                fontSize: 12
              ),
            )
          ],
        ), 
        isOwner: e.isOwner,
        margin: tempIsOwner == e.isOwner? 5 : 15
      );
      tempIsOwner = e.isOwner;
      return message;
    }).toList();

    messagesWidget.insert(0, getPurchase(chat.linkedPurchase));

    final sendMessage = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(1, 0),
            blurRadius: 3
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: GoogleFonts.montserrat(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: 'Enviar mensaje',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5.0
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: EcoAppColors.MAIN_COLOR,
            ), 
            onPressed: () => print('Send') // TODO: Send message
          ),
        ],
      ),
    );
    final scroll = SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.down,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: messagesWidget,
        ),
      ),
    );

    return Stack(
      children: [
        scroll,
        Align(
          child: sendMessage,
          alignment: Alignment.bottomCenter,
        )
      ],
    );
  }

  Widget getPurchase(PurchaseModel purchase){
    ImageProvider<Object> imgData;
    if(purchase.articles[0].hasPhotoUrl){
      imgData = NetworkImage(purchase.articles[0].photoUrl!);
    }
    else{
      imgData = AssetImage('assets/png/no-image.png');
    }

    final img = Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 1
          )
        ]
      ),
      child: Image(
        image: imgData, // TODO: Linked article
        fit: BoxFit.cover
      ),
    );

    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${purchase.articles.length} artículos',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.start
          ),
          Text(
            'Comprado: ${purchase.createdDate.day}/${purchase.createdDate.month}/${purchase.createdDate.year}',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w300,
              fontSize: 12
            ),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );

    return getMessage(
      content: Row(
        children: [
          img,
          SizedBox(width: 20),
          info
        ],
      ),
      isOwner: false
    );
  }

  Widget getMessage({required Widget content, required bool isOwner, double margin = 10}){
    return Container(
      margin: EdgeInsets.only(
        right: isOwner? 0 : 40,
        left: isOwner? 40 : 0,
        top: margin,
        //bottom: margin
      ),
      child: GestureDetector(
        onTap: () {}, // TODO: Go to purchase
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15.0
            ),
            child: content
          ),
        ),
      ),
    );
  }
}

