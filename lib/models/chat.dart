import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/models/store.dart';

class ChatModel extends BaseModel
{
  bool closed;
  DateTime createdDate;

  List<MessageModel> _messages = [];
  List<MessageModel> get messages { // TODO: Connect to api - DEBUG
    // Load messages
    _messages.addAll([
      MessageModel(
        id: id, 
        message: 'Hola hola sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'profile'
      ),
      MessageModel(
        id: id, 
        message: 'Hola hola jaja buena buena sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'store'
      ),
      MessageModel(
        id: id, 
        message: 'ahh chaochao sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'profile'
      ),
      MessageModel(
        id: id, 
        message: 'Hola hola sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'profile'
      ),
      MessageModel(
        id: id, 
        message: 'Hola hola jaja buena buena sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'store'
      ),
      MessageModel(
        id: id, 
        message: 'ahh chaochao sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'profile'
      ),
      MessageModel(
        id: id, 
        message: 'Hola hola sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'profile'
      ),
      MessageModel(
        id: id, 
        message: 'Hola hola jaja buena buena sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'store'
      ),
      MessageModel(
        id: id, 
        message: 'ahh chaochao sdfkjdsf', 
        date: DateTime.now(), 
        chat: this, 
        profile: ProfileModel(
          bithday: DateTime.now(),
          contactNumber: 123,
          createdDate: DateTime.now(),
          email: 'skdjfjadfs',
          id: 2,
          lastName: 'sadjksdjafk',
          lastUpdateDate: DateTime.now(),
          location: ' jsadfjdasksf a',
          name: ' kasdkjadfsk ',
          rut: 234234,
          rutDv: '4',
          termsChecked: true
        ), 
        store: store, 
        owner: 'profile'
      )
    ]);
    return _messages;
  }

  ChatModel({
    required int id,
    required this.closed,
    required this.createdDate,
  }) : super(id: id);

  StoreModel get store => StoreModel(
    id: 1, 
    publicName: 'dfdsfgs', 
    description: 'fgdgdgsgds', 
    email: 'dfsfgsfg', 
    contactNumber: 123123, 
    location: 'fsgfsfgs', 
    rut: 234234, 
    rutDv: 's', 
    enabled: true, 
    createdDate: createdDate, 
    lastUpdateDate: createdDate, 
    district: DistrictModel(id: 1, name: 'Penco')
  ); // TODO: Conenct to api - DEBUG

  PurchaseModel get linkedPurchase => PurchaseModel(
    id: id, 
    total: 23445, 
    createdDate: createdDate, 
    info: InfoPurchaseModel(
      contactNumber: '38289243',
      district: 'Penco',
      id: 1,
      location: 'dfgkdgf',
      names: ' askjjkadfs'
    ), articles: [
      ArticleToPurchase(
        id: id, 
        title: 'Un artículo a', 
        unitPrice: 12015, 
        quantity: 2,
        form: ArticleForm.infoPurchase(
          id: 1,
          generalDetail: '',
          recycledMats: 'sjadsf',
          recycledMatsDetail: 'sfkjasdkf',
          recycledProd: '',
          recycledProdDetail: '',
          reuseTips: 'dsafjdsafjk'
        )
      )
    ]
  );

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'closed'      : closed,
    'createdDate' : createdDate
  };


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
    required int id,
    required this.message,
    required this.date,
    required this.chat,
    required this.profile,
    required this.store,
    required this.owner
  }) : super(id: id);

  bool get isOwner => owner != 'store';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'message': message,
    'date': date,
    'chat': chat,
    'profile': profile,
    'store': store,
    'owner': owner,
  };
}