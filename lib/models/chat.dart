import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/models/store.dart';

class ChatModel extends BaseModel
{
  late bool closed;
  late DateTime createdDate;
  late StoreModel? store;
  late PurchaseModel purchase;

  late List<MessageModel> messages;

  ChatModel({
    required int id,
    required this.closed,
    required this.createdDate,
    required this.purchase,
    required this.store
  }) : super(id: id);

  ChatModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    closed           = json['closed'] != 0;
    createdDate      = DateTime.parse(json['creation_date']);
    store            = json['store'] != null? StoreModel.fromJsonMap(json['store']) : null;
    messages         = json['messages'].map<MessageModel>((e) => MessageModel.fromJsonMap(e)).toList() ?? const [];
    purchase         = PurchaseModel.fromJsonMap(json['purchase']);
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'closed'      : closed,
    'creation_date': createdDate.toString(),
    'purchase_id' : purchase.id,
    'store_id'    : store?.id ?? 0
  };


}

class MessageModel extends BaseModel
{
  late String message;
  late DateTime date;
  late bool fromStore;

  ChatModel? chat;

  MessageModel({
    required int id,
    required this.message,
    required this.date,
    this.chat,
    required this.fromStore
  }) : super(id: id);

  MessageModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    message           = json['message'];
    date              = DateTime.parse(json['creation_date']);
    fromStore         = json['from_store'] != 0;
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'message': message,
    'date': date.toString(),
    'from_store': fromStore? 1 : 0
  };
}