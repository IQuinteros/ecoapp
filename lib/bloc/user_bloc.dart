import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/sqlite/user_local_api.dart';
import 'package:flutter_ecoapp/providers/user_api.dart';

class UserBloc extends BaseBloc<UserModel>{

  final userAPI = UserAPI();
  final userLocalAPI = UserLocalAPI();

  UserBloc(initialState) : super(initialState);

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
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}