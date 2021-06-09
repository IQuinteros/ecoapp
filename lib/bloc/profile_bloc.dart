import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/bloc/district_bloc.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/providers/district_api.dart';
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
    await _updateCurrentSession();
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
    //_sessionStreamController.close();
  }

  /// Update current session with remote data
  Future<void> _updateCurrentSessionFromRemote() async {
    if(currentProfile == null) return;

    final profiles = await profileAPI.selectAll(params: {'id': currentProfile!.id});

    if(profiles.length > 0){
      await profileLocalAPI.clear();
      await profileLocalAPI.insert(profiles[0]);
      await _updateCurrentSession();
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

  /// Register profile
  Future<bool> signup(ProfileModel profile, String newPassword) async {
    ProfileModel? result = await profileAPI.insert(
      item: profile,
      additionalParams: {'passwords': newPassword}
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

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    print('MAPPING BLOC');
    throw UnimplementedError();
  }

  
}