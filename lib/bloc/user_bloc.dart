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

  @override
  Future<void> initializeBloc() async {
    await userLocalAPI.initialize();
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

    final result = await searchAPI.insert(
      item: SearchModel(
        id: 0, 
        searchText: search, 
        searchDate: DateTime.now()
      ), 
      additionalParams: {
        'user': user.id
      }
    );

    return result.object;
    
  }

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}