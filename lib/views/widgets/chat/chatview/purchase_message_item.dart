import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/views/purchase_detail_view.dart';
import 'package:flutter_ecoapp/views/widgets/chat/chatview/message_item.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseMessageItem extends StatelessWidget {
  const PurchaseMessageItem({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> imgData;
    if(chat.store != null){
      imgData = NetworkImage(chat.store!.photoUrl);
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
            '${chat.purchase!.articles.length} artículos',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.start
          ),
          Text(
            'Comprado: ${chat.purchase!.createdDate.day}/${chat.purchase!.createdDate.month}/${chat.purchase!.createdDate.year}',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w300,
              fontSize: 12
            ),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );

    return MessageItem(
      content: Row(
        children: [
          img,
          SizedBox(width: 20),
          info
        ],
      ),
      isOwner: false,
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => PurchaseDetailView(purchase: chat.purchase!,))),
    );
  }
}
