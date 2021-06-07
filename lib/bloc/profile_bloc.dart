import 'dart:async';

import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/providers/profile_api.dart';
import 'package:flutter_ecoapp/providers/sqlite/profile_local_api.dart';

class ProfileBloc extends BaseBloc<ProfileModel>{

  final ProfileAPI profileAPI = ProfileAPI();
  final ProfileLocalAPI profileLocalAPI = ProfileLocalAPI();

  ProfileBloc() : super(0){
    profileLocalAPI.initialize();

    // Get current getCurrentSession
    _getCurrentSession();
  }

  // Session streams  
  final _sessionStreamController = StreamController<ProfileModel?>.broadcast();

  Function(ProfileModel?) get sessionSink => _sessionStreamController.sink.add;
  Stream<ProfileModel?> get sessionStream => _sessionStreamController.stream;

  void disposeStreams(){
    _sessionStreamController.close();
  }


  Future<List<ProfileModel>> get getProfiles => profileAPI.selectAll();

  // Only get current session
  Future<ProfileModel?> _getCurrentSession() async { 
    List<ProfileModel> profiles = await profileLocalAPI.select();

    if(profiles.length > 0) return profiles[0];
    return null;
  }

  // Update current session
  Future<void> updateCurrentSession() async => sessionSink(await _getCurrentSession());

  // Login profile
  Future<ProfileModel?> login(String email, String password) async {
    ProfileModel? profile = await profileAPI.selectOne({'email': email, 'password': password});

    if(profile != null){
      (await profileLocalAPI.select()).forEach((element) async => await profileLocalAPI.delete(element.id));
      profileLocalAPI.insert(profile);
    }

    return profile;
  }

  // Register profile
  Future<bool> register(ProfileModel profile) async => (await profileAPI.insert(profile)) != null;

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}