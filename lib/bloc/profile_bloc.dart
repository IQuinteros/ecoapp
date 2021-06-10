import 'dart:async';
import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/favorite.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/district_api.dart';
import 'package:flutter_ecoapp/providers/favorite_api.dart';
import 'package:flutter_ecoapp/providers/profile_api.dart';
import 'package:flutter_ecoapp/providers/sqlite/profile_local_api.dart';
import 'package:flutter_ecoapp/providers/sqlite/user_local_api.dart';
import 'package:flutter_ecoapp/providers/user_api.dart';

class ProfileBloc extends BaseBloc<ProfileModel>{

  final ProfileAPI profileAPI = ProfileAPI();
  final ProfileLocalAPI profileLocalAPI = ProfileLocalAPI();

  ProfileBloc() : super(0){
  }

  @override
  Future<void> initializeBloc() async{
    await profileLocalAPI.initialize();
    await userLocalAPI.initialize();
    // Get current getCurrentSession
    await _updateCurrentSessionFromRemote();
  }

  /// Session streams  
  var _sessionStreamController = StreamController<ProfileModel?>.broadcast();

  ProfileModel? currentProfile;
  Function(ProfileModel?) get _sessionSink => _sessionStreamController.sink.add;
  Stream<ProfileModel?> get sessionStream => _sessionStreamController.stream;

  void disposeStreams(){
    _sessionStreamController.close();
  }

  /// Only get current session
  Future<ProfileModel?> _getCurrentSession() async { 
    List<ProfileModel> profiles = await profileLocalAPI.select();
    if(profiles.length > 0) return profiles[0];
    return null;
  }

  /// Update current session
  Future<void> _updateCurrentSession() async {
    final profile = await _getCurrentSession();
    _sessionSink(profile);
    currentProfile = profile;
    await loadDistrict();
    await _checkUserFromCurrentUser();
    //_sessionStreamController.close();
  }

  final userAPI = UserAPI();
  final userLocalAPI = UserLocalAPI();
  /// Check user
  Future<bool> _checkUserFromCurrentUser() async {
    if(currentProfile == null) return await _tryCreateNewLocalUser();

    final users = await userAPI.selectAll(
      params: {
        'id': currentProfile!.userId
      }
    );

    if(users.length > 0){
      // Load current profile user
      currentProfile!.user = users[0];
      // When currentProfile.user is loaded, widgets have to call to this. Otherwise, call to local user
      return true;
    }
    else{
      return await _tryCreateNewLocalUser();
    }
  }

  Future<bool> _tryCreateNewLocalUser() async {
    List<UserModel> users = await userLocalAPI.select();

    if(users.length <= 0){
      final result = await userAPI.insert(
        item: UserModel(
          id: 0, 
          createdDate: DateTime.now()
        )
      );

      if(result == null) return false;
      
      await userLocalAPI.clear();
      await userLocalAPI.insert(result);
    }
    else{
      final isInRemote = await userAPI.selectAll(
        params: {
          'id': users[0].id
        }
      );

      if(isInRemote.length > 0){
        return true;
      }
      else{
        // TODO: FIRST CHECK IF THERE IS CONNECTION (CAN DELETE LOCAL USER WHEN IS DISCONNECTED)
        //await userLocalAPI.delete(users[0].id);
        //userAPI.ping((value) => print);
        return true;
      }
    }

    return true;
    
  }

  /// Update current session with remote data
  Future<void> _updateCurrentSessionFromRemote() async {
    await _updateCurrentSession();
    if(currentProfile == null) return;

    final profiles = await profileAPI.selectAll(params: {'id': currentProfile!.id});

    if(profiles.length > 0){
      await profileLocalAPI.clear();
      await profileLocalAPI.insert(profiles[0]);
    }
  }
  
  /// Login profile
  Future<ProfileModel?> login(String email, String password) async {
    List<ProfileModel> profile = await profileAPI.selectAll(
      params: {'email': email, 'password': password},
      customName: 'login'
    );

    if(profile.length > 0){
      await profileLocalAPI.clear();
      await profileLocalAPI.insert(profile[0]);
      await _updateCurrentSession();
      return profile[0];
    }
    else{
      return null;
    }
  }

  // Only for load district
  final DistrictAPI districtAPI = DistrictAPI();
  // Get district of profile
  Future<void> loadDistrict() async{
    if(currentProfile == null) return;

    final districts = await districtAPI.selectAll(
      params: {'id': currentProfile!.districtID ?? 0}
    );

    if(districts.length > 0){
      currentProfile!.district = districts[0];
      return;
    }

    currentProfile!.district = null;
  }

  /// Can login?
  Future<bool> canLogin(String email, String password) async => (await profileAPI.selectAll(
    params: {'email': email, 'password': password},
    customName: 'login'
  )).length > 0;

  /// Logout profile
  Future<void> logout() async {
    await profileLocalAPI.clear();
    //_sessionStreamController = StreamController<ProfileModel?>.broadcast();
    await _updateCurrentSession();
  }

  /// Check email profile exists
  Future<bool> exists(ProfileModel profile) async{
    List<ProfileModel> result = await profileAPI.selectAll(params: {'email': profile.email});

    return result.length > 0;
  }

  /// Change password
  Future<bool> changePassword(String newPass) async {
    if(currentProfile == null) return false;

    return await (profileAPI.update(
      item: currentProfile!, 
      additionalParams: {'password': newPass},
      customName: 'update_pass'
    )) != null;
  }

  /// Register profile (TODO: Check for upload local user) SOLUTION: When user is used, create new
  Future<bool> signup(ProfileModel profile, String newPassword) async {
    List<UserModel> users = await userLocalAPI.select();

    if(users.length > 0){
      profile.userId = users[0].id;
    }

    final result = await profileAPI.insert(
      item: profile,
      additionalParams: {
        'passwords': newPassword,
      }
    );

    if(result != null){
      await profileLocalAPI.clear();
      await profileLocalAPI.insert(result);
      await _updateCurrentSession();
    }

    return result != null;

  }

  /// Update profile
  Future<bool> updateProfile(ProfileModel profile) async {
    ProfileModel? result = await profileAPI.update(item: profile);

    if(result != null)
    {
      await profileLocalAPI.update(profile);
      await _updateCurrentSession();
    }

    return result != null;
  }

  final favoriteAPI = FavoriteAPI();
  Map<ArticleModel, Timer?> favoriteTimer = {};
  /// Mark as favorite
  void setFavoriteArticle(ArticleModel articleModel, bool newState, Function(bool) onReady) {
    articleModel.favorite = newState;

    if(favoriteTimer[articleModel] != null) favoriteTimer[articleModel]!.cancel();
    favoriteTimer[articleModel] = Timer(Duration(seconds: 5), () => _setFavoriteArticle(articleModel, onReady));
  }

  Future<void> _setFavoriteArticle(ArticleModel articleModel, Function(bool) onReady) async {
    if(currentProfile == null) {
      onReady(false); 
      return;
    }

    if(articleModel.favorite){
      onReady((await favoriteAPI.insert(
        item: FavoriteModel(
          id: 0, 
          article: articleModel, 
          createdDate: DateTime.now()
        )
      )) != null);
    }
    else{
      onReady(await favoriteAPI.delete(
        item: FavoriteModel(
          id: 0, 
          article: articleModel, 
          createdDate: DateTime.now()
        ),
        params: {
          'user': currentProfile!.userId
        }
      ));
    }
  }
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    print('MAPPING BLOC');
    throw UnimplementedError();
  }

  
}