import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/chat_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/purchase_bloc.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/views/chat_view.dart';
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
        unselected: true,
        onTap: (value){
          Navigator.pop(context, value);
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
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final chatBloc = BlocProvider.of<ChatBloc>(context);

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
        vertical: 20.0,
        horizontal: 10
      ),
      child: FutureBuilder(
        future: chatBloc.getProfileChats(profileBloc.currentProfile!),
        builder: (context, AsyncSnapshot<List<ChatModel>> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              return Column(
                children: snapshot.data!.map<_ChatItem>((e) => _ChatItem(chat: e)).toList()
              );
            default: return CircularProgressIndicator();
          }
        }
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
        image: (NetworkImage(chat.store?.photoUrl??'')), // TODO: 
        fit: BoxFit.cover,
      ),
    );

    List<MessageModel> storeMessages = chat.messages.where((element) => element.fromStore).toList();

    final info = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chat.store?.publicName ?? 'Tienda desconocida',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            storeMessages.length > 0? storeMessages.last.message : 'No ha respondido aún',
            style: GoogleFonts.montserrat(
              fontStyle: storeMessages.length > 0? FontStyle.normal : FontStyle.italic,
              fontWeight: storeMessages.length > 0? FontWeight.w400 : FontWeight.w300
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );

    final status = storeMessages.length > 0 && storeMessages.last.date.isAfter(chat.lastSeenDate)? Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: EcoAppColors.RED_COLOR
      ),
    ) : Container();

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => ChatView(chat: chat,))),
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

