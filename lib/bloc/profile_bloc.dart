import 'dart:async';

import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/providers/profile_api.dart';

class ProfileBloc extends BaseBloc<ProfileModel>{

  final ProfileAPI profileAPI = ProfileAPI();

  ProfileBloc() : super(0);

  final _profilesStreamController = StreamController<ProfileModel>.broadcast();

  Function(ProfileModel) get profileSink => _profilesStreamController.sink.add;
  Stream<ProfileModel> get profileStream => _profilesStreamController.stream;

  void disposeStreams(){
    _profilesStreamController.close();
  }

  String get testing => "TESTING WORKING";

  Future<List<ProfileModel>> get getProfiles => profileAPI.selectAll();

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}