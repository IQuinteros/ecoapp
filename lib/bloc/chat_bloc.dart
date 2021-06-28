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

  Future<List<ChatModel>> getChatsFromPurchase(PurchaseModel purchase) async {
    final chats = await chatAPI.selectAll(
      params: {
        'purchase_id': purchase.id
      }
    );

    return chats;
  }

  Future<List<MessageModel>> getMessagesFromChat(ChatModel chat) async => await messageAPI.selectAll(
    params: {
      'chat': chat
    }
  );

  Future<bool> deleteMessage(MessageModel message){
    return messageAPI.delete(item: message);
  }

  Future<bool> updateLastSeenDate(ChatModel chat) async {
    final result = (await chatAPI.update(item: chat, customName: 'update_date'));

    if(result != null){
      chat.lastSeenDate = DateTime.now();
      return true;
    }
    return false;
  }

  Future<SendMessageResult> sendMessage({
    required MessageModel message,
    required ProfileModel profile,
    required PurchaseModel purchase,
    StoreModel? store,
  }) async {
    List<ChatModel> chats = await getChatsFromPurchase(purchase);
    chats = chats.where((element) => element.store?.id == store?.id).toList();

    if(chats.length > 0){
      return SendMessageResult(result: (await messageAPI.insert(
        item: message,
        additionalParams: {
          'chat_id': chats[0].id
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