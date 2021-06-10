import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/history.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/history_api.dart';

class HistoryBloc extends BaseBloc<HistoryModel>{

  final historyAPI = HistoryAPI();
  final historyDetailAPI = HistoryDetailAPI();

  @override
  Future<void> initializeBloc() async {
    return;
  }
  
  Future<List<HistoryModel>> getHistory({required UserModel user, bool includeDeleted = false}) async {
    return await historyAPI.selectAll(params: {
      'user': user.id,
      'include_deleted': includeDeleted
    });
  }

  Future<bool> addToHistory({required UserModel user, required ArticleModel article}) async {
    List<HistoryModel> history = await historyAPI.selectAll(
      params: {
        'article': article.id,
        'user': user.id
      }
    );

    if(history.length > 0){
      HistoryDetailModel newHistoryDetail = HistoryDetailModel(
        id: 0, 
        date: DateTime.now(),
        history: history[0]
      );
      return (await historyDetailAPI.insert(
        item: newHistoryDetail,
      )) != null;
    }
    else{
      HistoryModel newHistory = HistoryModel(
        id: 0,
        article: article,
        deleted: false,
        createdDate: DateTime.now()
      );

      return (await historyAPI.insert(
        item: newHistory,
        additionalParams: {
          'user': user.id
        }
      )) != null;
    }

    
  }
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}