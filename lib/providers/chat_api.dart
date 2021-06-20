import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class ChatAPI extends BaseAPI<ChatModel>{
  ChatAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'chat',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => ChatModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}

class MessageAPI extends BaseAPI<MessageModel>{
  MessageAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'message',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => MessageModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}
