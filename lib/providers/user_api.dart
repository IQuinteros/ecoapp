import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class UserAPI extends BaseAPI<UserModel>{
  UserAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'user',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => UserModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}
