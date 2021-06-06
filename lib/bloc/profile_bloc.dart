import 'dart:async';

import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';

class ProfileBloc extends BaseBloc<ProfileModel>{
  final _profilesStreamController = StreamController<ProfileModel>.broadcast();
  Function(ProfileModel) get profileSink => _profilesStreamController.sink.add;
  Stream<ProfileModel> get profileStream => _profilesStreamController.stream;

  void disposeStreams(){
    _profilesStreamController.close();
  }
}