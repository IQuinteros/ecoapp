import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/chat/chatview/message_item.dart';
import 'package:flutter_ecoapp/views/widgets/chat/chatview/purchase_message_item.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatefulWidget {

  final ChatModel chat;

  ChatView({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
        centerTitle: false,
        elevation: 10,
        title: Text(
          widget.chat.store?.publicName ?? 'Tienda desconocida',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded),
          color: Colors.white,
          iconSize: 40,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: mainContent(context)
    );
  }

  Widget mainContent(BuildContext context){
    List<MessageModel> messages = widget.chat.messages;
    bool tempIsOwner = false;
    List<Widget> messagesWidget = messages.map<Widget>((e) { 
      Widget message = MessageItem(
        content: Column(
          crossAxisAlignment: !e.fromStore? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
        isOwner: !e.fromStore,
        margin: tempIsOwner == !e.fromStore? 5 : 15
      );
      tempIsOwner = !e.fromStore;
      return message;
    }).toList();

    messagesWidget.insert(0, PurchaseMessageItem(purchase: widget.chat.purchase!)); // TODO:
    messagesWidget.add(SizedBox(height: 90,));

    final sendMessage = Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0
      ),
      decoration: BoxDecoration(
        //color: EcoAppColors.MAIN_DARK_COLOR,
      ),
      child: BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
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
              ),
              SizedBox(width: 10.0,),
              Container(
                decoration: BoxDecoration(
                  color: EcoAppColors.MAIN_COLOR,
                  shape: BoxShape.circle
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white
                  ), 
                  onPressed: () => print('Send') // TODO: Send message
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final scroll = SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.down,
      controller: ScrollController(
        initialScrollOffset: messages.length * 80
      ),
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
        SafeArea(child: scroll),
        Align(
          alignment: Alignment.bottomCenter,
          child: sendMessage,
        )
      ],
    );
  }
}


