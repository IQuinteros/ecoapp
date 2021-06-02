import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({ 
    Key? key, 
    required this.isOwner,
    required this.content,
    this.margin = 10
  }) : super(key: key);

  final bool isOwner;
  final Widget content;
  final double margin;

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
            child: widget.content
          ),
        ),
      ),
    );
  }
}