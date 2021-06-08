import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/providers/sqlite/base_local_api.dart';

class ProfileLocalAPI extends BaseLocalAPI<ProfileModel>{

  ProfileLocalAPI() : super(
    constructor: (value) => ProfileModel.fromJsonMap(value),
    toMapFunction: (item) => item.toSqliteParams(),
    params: 'id INTEGER PRIMARY KEY, name TEXT, last_name TEXT, email TEXT, contact_number INTEGER, birthday TEXT, terms_checked INTEGER, location TEXT, creation_date TEXT, last_update_date TEXT, rut INTEGER, rut_cd TEXT, district INTEGER, user INTEGER',
    tableName: 'profile'
  );

}