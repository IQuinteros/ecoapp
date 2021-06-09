import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/history.dart';
import 'package:flutter_ecoapp/models/search.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/history_api.dart';
import 'package:flutter_ecoapp/providers/search_api.dart';
import 'package:flutter_ecoapp/providers/sqlite/user_local_api.dart';
import 'package:flutter_ecoapp/providers/user_api.dart';

class UserBloc extends BaseBloc<UserModel>{

  final userAPI = UserAPI();
  final searchAPI = SearchAPI();
  final userLocalAPI = UserLocalAPI();

  UserBloc() : super(0);

  Future<void> initUser() async {
    final users = await userLocalAPI.select();

    if(users.length > 0) return;

    final result = await userAPI.insert(item: UserModel(
      id: 0,
      createdDate: DateTime.now()
    ));

    if(result != null){
      await userLocalAPI.clear();
      await userLocalAPI.insert(result);
    }
  }

  Future<UserModel?> getLinkedUser() async {
    final users = await userLocalAPI.select();
    if(users.length > 0)
      return users[0];
    else return null;
  }

  Future<void> setLinkedUser(UserModel user) async {
    await userLocalAPI.clear();
    await userLocalAPI.insert(user);
  }
  
  Future<SearchModel?> uploadNewSearch(String search) async {
    UserModel? user = await getLinkedUser();
    if(user == null) return null;

    if(search.isEmpty) return null;

    return await searchAPI.insert(
      item: SearchModel(
        id: 0, 
        searchText: search, 
        searchDate: DateTime.now()
      ), 
      additionalParams: {
        'user': user.id
      }
    );
  }

  final historyAPI = HistoryAPI();
  final historyDetailAPI = HistoryDetailAPI();
  
  Future<List<HistoryModel>> getHistory({bool includeDeleted = false}) async {
    UserModel? user = await getLinkedUser();
    if(user == null) return [];

    return await historyAPI.selectAll(params: {
      'user': user.id,
      'include_deleted': includeDeleted
    });
  }

  Future<bool> addToHistory(ArticleModel article) async {
    UserModel? user = await getLinkedUser();
    if(user == null) return false;

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