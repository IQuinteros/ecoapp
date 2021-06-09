import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/search.dart';
import 'package:flutter_ecoapp/models/user.dart';
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

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}