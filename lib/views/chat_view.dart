import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/chat_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/chat/chatview/message_item.dart';
import 'package:flutter_ecoapp/views/widgets/chat/chatview/purchase_message_item.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatefulWidget {

  final ChatModel? chat;

  final StoreModel? store;
  final PurchaseModel? purchase;

  final TextEditingController messageController = TextEditingController();

  ChatView({Key? key, required this.chat, this.store, this.purchase}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  ChatModel? refreshChat;
  bool firstRun = false;

  @override
  Widget build(BuildContext context) {

    ChatModel? chatToUse = refreshChat ?? widget.chat;

    if(chatToUse != null){
      Timer(Duration(seconds: 8), () async {
        await updateChat(context, chatToUse);
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
        centerTitle: false,
        elevation: 10,
        title: Text(
          widget.store?.publicName ?? chatToUse!.store?.publicName ?? 'Tienda desconocida',
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
      body: mainContent(context, chatToUse)
    );
  }

  Widget mainContent(BuildContext context, ChatModel? chatToUse){
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    List<MessageModel> messages = chatToUse?.messages ?? const [];
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

    if(chatToUse != null) messagesWidget.insert(0, PurchaseMessageItem(chat: chatToUse));
    messagesWidget.add(SizedBox(height: 90,));

    final scrollController = ScrollController(initialScrollOffset: messages.length * 80);

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
                    controller: widget.messageController,
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
                  onPressed: () async { 
                    await chatBloc.sendMessage(
                      message: MessageModel(
                        message: widget.messageController.text,
                        date: DateTime.now(),
                        fromStore: false,
                        id: 0,
                        chat: chatToUse
                      ), 
                      profile: profileBloc.currentProfile!, 
                      purchase: chatToUse?.purchase ?? widget.purchase!
                    );
                    await updateChat(context, chatToUse, () => scrollController.jumpTo(messages.length * 50));
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final scroll = SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.down,
      controller: scrollController,
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
        SafeArea(
          child: chatToUse != null? RefreshIndicator(
            child: scroll,
            onRefresh: () async => await updateChat(context, chatToUse)
          ) : _NoChatView(store: widget.store, purchase: widget.purchase,)
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: sendMessage,
        )
      ],
    );
  }

  Future<void> updateChat(BuildContext context, ChatModel? chatToUse, [Function()? onSetState]) async {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    refreshChat = await chatBloc.getChatFromPurchase(chatToUse?.purchase ?? widget.purchase!);

    if(widget.chat != null && refreshChat != null){
      widget.chat!.messages = refreshChat!.messages;
    }

    setState(() {
      onSetState?.call();
    });
  }
}

class _NoChatView extends StatelessWidget {
  const _NoChatView({
    Key? key,
    required this.store,
    required this.purchase
  }) : super(key: key);

  final StoreModel? store;
  final PurchaseModel? purchase;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Spacer(),
            Text(
              'No has iniciado una conversación con ${store?.publicName ?? "el vendedor"}',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Haz preguntas sobre tu compra #${purchase?.id ?? "0"}. Inicia el chat escribiendo un mensaje para tu vendedor',
              style: GoogleFonts.montserrat(
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}


