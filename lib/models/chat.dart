import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/store.dart';

class ChatModel extends BaseModel
{
  bool closed;
  DateTime createdDate;

  List<MessageModel> messages;

  ChatModel({
    @required int id,
    @required this.closed,
    @required this.createdDate,
    this.messages = const []
  }) : super(id: id);
}

class MessageModel extends BaseModel
{
  String message;
  DateTime date;
  String owner;

  ChatModel chat;
  ProfileModel profile;
  StoreModel store;

  MessageModel({
    @required int id,
    @required this.message,
    @required this.date,
    @required this.chat,
    @required this.profile,
    @required this.store
  }) : super(id: id);
}