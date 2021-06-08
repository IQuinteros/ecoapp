import 'dart:async';

import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/providers/profile_api.dart';
import 'package:flutter_ecoapp/providers/sqlite/profile_local_api.dart';
import 'package:path/path.dart';

class ProfileBloc extends BaseBloc<ProfileModel>{

  final ProfileAPI profileAPI = ProfileAPI();
  final ProfileLocalAPI profileLocalAPI = ProfileLocalAPI();

  ProfileBloc() : super(0){
    initializeBloc();
  }

  void initializeBloc() async{
    await profileLocalAPI.initialize();
    // Get current getCurrentSession
    _updateCurrentSession();
  }

  // Session streams  
  var _sessionStreamController = StreamController<ProfileModel?>.broadcast();

  ProfileModel? currentProfile;
  Function(ProfileModel?) get _sessionSink => _sessionStreamController.sink.add;
  Stream<ProfileModel?> get sessionStream => _sessionStreamController.stream;

  void disposeStreams(){
    _sessionStreamController.close();
  }

  // TODO: Delete this variable (Currently is only for testing)
  Future<List<ProfileModel>> get getProfiles => profileAPI.selectAll();

  // Only get current session
  Future<ProfileModel?> _getCurrentSession() async { 
    List<ProfileModel> profiles = await profileLocalAPI.select();
    if(profiles.length > 0) return profiles[0];
    return null;
  }

  // Update current session
  Future<void> _updateCurrentSession() async {
    final profile = await _getCurrentSession();
    _sessionSink(profile);
    currentProfile = profile;
    //_sessionStreamController.close();
  }
  
  // Login profile
  Future<ProfileModel?> login(String email, String password) async {
    List<ProfileModel> profile = await profileAPI.selectAll(
      params: {'email': email, 'password': password},
      customName: 'login'
    );


    if(profile.length > 0){
      await profileLocalAPI.clear();
      await profileLocalAPI.insert(profile[0]);
      _updateCurrentSession();
      return profile[0];
    }
    else{
      return null;
    }
  }

  // Logout profile
  Future<void> logout() async {
    await profileLocalAPI.clear();
    //_sessionStreamController = StreamController<ProfileModel?>.broadcast();
    await _updateCurrentSession();
  }

  // Register profile
  Future<bool> register(ProfileModel profile) async => (await profileAPI.insert(item: profile)) != null;

  // Update profile
  Future<bool> updateProfile(ProfileModel profile) async {
    ProfileModel? result = await profileAPI.update(item: profile);

    if(result != null)
    {
      await profileLocalAPI.update(profile);
      await _updateCurrentSession();
    }

    return result != null;
  }

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    print('MAPPING BLOC');
    throw UnimplementedError();
  }

  
}