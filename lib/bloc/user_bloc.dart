import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
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

  @override
  Future<void> initializeBloc() async {
    await userLocalAPI.initialize();
  }

  Future<UserModel?> getLinkedUser(ProfileModel? profile) async {
    if(profile != null && profile.user != null) return profile.user;
    
    final users = await userLocalAPI.select();
    if(users.length > 0)
      return users[0];
    else return null;
  }

  Future<void> setLinkedUser(UserModel user) async {
    await userLocalAPI.clear();
    await userLocalAPI.insert(user);
  }
  
  Future<SearchModel?> uploadNewSearch(ProfileModel? profile, String search) async {
    UserModel? user = await getLinkedUser(profile);
    if(user == null) return null;

    if(search.isEmpty) return null;

    final result = await searchAPI.insert(
      item: SearchModel(
        id: 0, 
        searchText: search, 
        searchDate: DateTime.now()
      ), 
      additionalParams: {
        'user_id': user.id
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