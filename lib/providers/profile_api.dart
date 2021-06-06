
import 'package:flutter_ecoapp/providers/base_api.dart';
import 'package:flutter_ecoapp/models/profile.dart';

class ProfileAPI extends BaseAPI<ProfileModel>{
  ProfileAPI() : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => ProfileModel.fromJsonMap(data)
  );
}
