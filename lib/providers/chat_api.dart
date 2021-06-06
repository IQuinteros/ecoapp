import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class ChatAPI extends BaseAPI<ChatModel>{
  ChatAPI() : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => ChatModel.fromJsonMap(data)
  );
}
