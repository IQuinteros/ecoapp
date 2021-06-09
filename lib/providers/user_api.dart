import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class UserAPI extends BaseAPI<UserModel>{
  UserAPI() : super(
    baseUrl: 'user',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => UserModel.fromJsonMap(data)
  );
}
