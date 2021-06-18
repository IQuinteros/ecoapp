import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/views/widgets/chat/chatview/message_item.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseMessageItem extends StatelessWidget {
  const PurchaseMessageItem({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  final PurchaseModel purchase;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> imgData;
    if(purchase.articles.length > 0 && purchase.articles[0].hasPhotoUrl){
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

    return MessageItem(
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
}
