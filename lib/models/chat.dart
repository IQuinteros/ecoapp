import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class ChatModel extends BaseModel
{
  bool closed;
  DateTime createdDate;

  ChatModel({
    @required int id,
    @required this.closed,
    @required this.createdDate,
  }) : super(id: id);
}

class MessageModel extends BaseModel
{
  String message;
  DateTime date;

  MessageModel({
    @required int id,
    @required this.message,
    @required this.date,
  }) : super(id: id);
}