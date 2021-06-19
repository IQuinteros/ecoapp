import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/providers/chat_api.dart';
import 'package:flutter_ecoapp/providers/purchase_api.dart';

class ChatBloc extends BaseBloc<ChatModel>{

  final ChatAPI chatAPI = ChatAPI();
  final MessageAPI messageAPI = MessageAPI();
  final articlePurchaseAPI = ArticlePurchaseAPI();

  @override
  Future<void> initializeBloc() async {
    return;
  }

  Future<ChatModel?> getChatFromPurchase(PurchaseModel purchase) async {
    final chats = await chatAPI.selectAll(
      params: {
        'purchase_id': purchase.id
      }
    );

    if(chats.length > 0)
      return chats[0];

    return null;
  }

  Future<List<MessageModel>> getMessagesFromChat(ChatModel chat) async => await messageAPI.selectAll(
    params: {
      'chat': chat
    }
  );

  Future<SendMessageResult> sendMessage({
    required MessageModel message,
    required ProfileModel profile,
    required PurchaseModel purchase,
    StoreModel? store,
  }) async {
    final chat = await getChatFromPurchase(purchase);

    if(chat != null){
      return SendMessageResult(result: (await messageAPI.insert(
        item: message,
        additionalParams: {
          'chat_id': chat.id
        }
      )).object != null, isNewChat: false);
    }
    else{

      final newChat = await chatAPI.insert(
        item: ChatModel(
          id: 0, 
          closed: false, 
          createdDate: DateTime.now(),
          purchase: purchase,
          store: store
        ),
      );

      if(newChat.object != null){
        return SendMessageResult(result: (await messageAPI.insert(
          item: message,
          additionalParams: {
            'chat_id': newChat.object!.id
          }
        )).object != null, isNewChat: true);
      }
        
      return SendMessageResult(result: false, isNewChat: false);
    }
  }

  Future<List<ChatModel>> getProfileChats(ProfileModel profile) => chatAPI.selectAll(params: {'profile_id': profile.id});
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}

class SendMessageResult{
  final bool result;
  final bool isNewChat;

  SendMessageResult({required this.result, required this.isNewChat});
}