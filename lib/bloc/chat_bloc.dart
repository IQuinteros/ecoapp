import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/providers/chat_api.dart';
import 'package:flutter_ecoapp/providers/purchase_api.dart';

class ChatBloc extends BaseBloc<ChatModel>{

  final ChatAPI chatAPI = ChatAPI();
  final MessageAPI messageAPI = MessageAPI();
  final articlePurchaseAPI = ArticlePurchaseAPI();

  ChatBloc() : super(0);

  Future<ChatModel?> getChatFromPurchase(PurchaseModel purchase) async {
    final chats = await chatAPI.selectAll(
      params: {
        'purchase': purchase.id
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

  Future<bool> sendMessage({
    required MessageModel message,
    required ProfileModel profile,
    required PurchaseModel purchase
  }) async {
    final chat = await getChatFromPurchase(purchase);

    if(chat != null){
      return (await messageAPI.insert(
        item: message,
      )) != null;
    }
    else{
      final newChat = await chatAPI.insert(
        item: ChatModel(
          id: 0, 
          closed: false, 
          createdDate: DateTime.now()
        ),
        additionalParams: {
          'purchase': purchase.id,
          'profile': profile.id
        }
      );

      if(newChat != null){
        return (await messageAPI.insert(
          item: message,
          additionalParams: {
            'chat': newChat.id
          }
        )) != null;
      }
      else{
        return false;
      }
    }
  }

  Future<List<ArticleToPurchase>> getArticlesFromPurchase(PurchaseModel purchase) async => await articlePurchaseAPI.selectAll(
    params: {
      'purchase': purchase.id
    }
  );
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}