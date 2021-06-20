import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({ 
    Key? key, 
    required this.isOwner,
    required this.content,
    this.margin = 10,
    this.onTap,
    this.onLongPress
  }) : super(key: key);

  final bool isOwner;
  final Widget content;
  final double margin;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: widget.isOwner? 0 : 40,
        left: widget.isOwner? 40 : 0,
        top: widget.margin,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
         boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 2.0,
            color: Colors.black.withOpacity(0.25)
          ),
        ] 
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          borderRadius: BorderRadius.circular(20.0),
          child: Card(
            color: Colors.transparent,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0
              ),
              child: widget.content
            ),
          ),
        ),
      ),
    );
  }
}