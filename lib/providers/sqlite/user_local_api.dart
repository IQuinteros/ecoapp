import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/sqlite/base_local_api.dart';

class UserLocalAPI extends BaseLocalAPI<UserModel>{

  UserLocalAPI() : super(
    constructor: (value) => UserModel.fromJsonMap(value),
    toMapFunction: (item) => item.toSqliteParams(),
    params: 'id INTEGER PRIMARY KEY, created_date TEXT',
    tableName: 'user'
  );

}