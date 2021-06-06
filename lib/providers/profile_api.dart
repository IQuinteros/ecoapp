
import 'package:flutter_ecoapp/providers/base_api.dart';
import 'package:flutter_ecoapp/models/profile.dart';

class ProfileAPI extends BaseAPI<ProfileModel>{
  ProfileAPI() : super(baseUrl: '');

  @override
  Future<ProfileModel> insert(ProfileModel item) {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(ProfileModel item) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProfileModel>> select_all([byParam]) {
    throw UnimplementedError();
  }

  @override
  Future<ProfileModel> select_one(byParam) {
    throw UnimplementedError();
  }

  @override
  Future<ProfileModel> update(ProfileModel actualItem, ProfileModel newItem) {
    throw UnimplementedError();
  }
}