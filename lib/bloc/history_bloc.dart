import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/history.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/article_api.dart';
import 'package:flutter_ecoapp/providers/history_api.dart';

class HistoryBloc extends BaseBloc<HistoryModel>{

  final historyAPI = HistoryAPI();
  final historyDetailAPI = HistoryDetailAPI();
  final articleAPI = ArticleAPI();

  @override
  Future<void> initializeBloc() async {
    return;
  }
  
  Future<List<ArticleModel>> getHistory({required UserModel user, bool includeDeleted = false, required ProfileModel? profile}) async {
    final histories = await historyAPI.selectAll(params: {
      'user_id': user.id,
    }..addAll(includeDeleted? {} : {'deleted' : 0}));

    final articles = await articleAPI.selectAll(
      params: {
        'id_list': histories.map((e) => e.articleId).toList()
      }..addAll( profile != null? {'profile_id': profile.id} : {})
    );

    return articles;
  }

  Future<void> _switchDeleted(ArticleModel linkedArticle, UserModel user, bool newDelete) async {
    await historyAPI.update(
      item: HistoryModel(id: 0, articleId: linkedArticle.id, createdDate: DateTime.now(), deleted: newDelete),
      customName: 'update_deleted',
      additionalParams: {
        'user_id': user.id
      }
    );
  }

  Future<void> deleteHistory(ArticleModel linkedArticle, UserModel user) async => await _switchDeleted(linkedArticle, user, true);
  Future<void> _undeleteHistory(ArticleModel linkedArticle, UserModel user) async => await _switchDeleted(linkedArticle, user, false);

  Future<bool> addToHistory({required UserModel user, required ArticleModel article}) async {
    List<HistoryModel> history = await historyAPI.selectAll(
      params: {
        'article_id': article.id,
        'user_id': user.id
      }
    );

    if(history.length > 0){
      HistoryDetailModel newHistoryDetail = HistoryDetailModel(
        id: 0, 
        date: DateTime.now(),
        history: history[0]
      );
      await _undeleteHistory(article, user);
      return (await historyDetailAPI.insert(
        item: newHistoryDetail,
      )).object != null;
    }
    else{
      HistoryModel newHistory = HistoryModel(
        id: 0,
        articleId: article.id,
        deleted: false,
        createdDate: DateTime.now()
      );

      return (await historyAPI.insert(
        item: newHistory,
        additionalParams: {
          'user_id': user.id
        }
      )).object != null;
    }

    
  }
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}