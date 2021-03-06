import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/district_bloc.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/user.dart';

class ProfileModel extends BaseModel
{
  late String name;
  late String lastName;
  late String email;
  late int contactNumber;
  late DateTime birthday;
  late bool termsChecked;
  late String location;
  late DateTime createdDate;
  late DateTime lastUpdateDate;
  late int rut;
  late String rutDv;
  int? districtID;

  late int userId;
  
  DistrictModel? district;
  
  UserModel? user;

  String get fullName => '$name $lastName';

  ProfileModel({
    required int id,
    required this.name,
    required this.lastName,
    required this.email, 
    required this.contactNumber,
    required this.birthday,
    required this.termsChecked,
    this.location = '',
    required this.createdDate,
    required this.lastUpdateDate,
    required this.rut,
    required this.rutDv,
    required this.district
  }) : super(id: id);

  ProfileModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    name            = json['name'];
    lastName        = json['last_name'];
    email           = json['email'];
    contactNumber   = json['contact_number'];
    birthday        = DateTime.parse(json['birthday']);
    termsChecked    = json['terms_checked'] is bool? json['terms_checked'] : json['terms_checked'] != 0;
    location        = json['location'];
    createdDate     = DateTime.parse(json['creation_date']);
    lastUpdateDate  = DateTime.parse(json['last_update_date']);
    rut             = json['rut'];
    rutDv           = json['rut_cd'];
    districtID      = json['district_id'] ?? json['district'];
    userId          = json['user_id'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'              : this.id,
    'name'            : this.name,
    'last_name'        : this.lastName,
    'email'           : this.email,
    'contact_number'   : this.contactNumber,
    'birthday'         : this.birthday.toString(),
    'terms_checked'    : this.termsChecked,
    'district_id'          : this.district?.id ?? districtID,
    'location'          : this.location,
    'rut'             : this.rut,
    'rut_cd'           : this.rutDv,
    'creation_date'     : this.createdDate.toString(),
    'last_update_date'  : this.lastUpdateDate.toString(),
    'user_id'              : this.userId,
  };

  @override
  Map<String, dynamic> toSqliteParams(){
    final json = super.toSqliteParams();
    json['terms_checked'] = termsChecked? 1 : 0;
    json['district'] = json['district_id'];
    json.remove('district_id');
    return json;
  }
}