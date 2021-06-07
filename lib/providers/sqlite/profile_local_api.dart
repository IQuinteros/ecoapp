import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/providers/sqlite/base_local_api.dart';

class ProfileLocalAPI extends BaseLocalAPI<ProfileModel>{

  ProfileLocalAPI() : super(
    constructor: (value) => ProfileModel.fromJsonMap(value),
    toMapFunction: (item) => item.toJson(),
    params: 'id INTEGER PRIMARY KEY, name TEXT, lastName TEXT, email TEXT, contactNumber INTEGER, bithday TEXT, termsChecked INTEGER, location TEXT, createdDate TEXT, lastUpdateDate TEXT, rut INTEGER, rutDv TEXT',
    tableName: 'profile'
  );

}