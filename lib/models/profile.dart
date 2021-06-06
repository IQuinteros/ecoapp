import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class ProfileModel extends BaseModel
{
  late String name;
  late String lastName;
  late String email;
  late int contactNumber;
  late DateTime bithday;
  late bool termsChecked;
  late String location;
  late DateTime createdDate;
  late DateTime lastUpdateDate;
  late int rut;
  late String rutDv;

  ProfileModel({
    required int id,
    required this.name,
    required this.lastName,
    required this.email, 
    required this.contactNumber,
    required this.bithday,
    required this.termsChecked,
    required this.location,
    required this.createdDate,
    required this.lastUpdateDate,
    required this.rut,
    required this.rutDv,
  }) : super(id: id);

  ProfileModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    name            = json['name'];
    lastName        = json['lastName'];
    email           = json['email'];
    contactNumber   = json['contactNumber'];
    bithday         = json['bithday'];
    termsChecked    = json['termsChecked'];
    location        = json['location'];
    createdDate     = json['createdDate'];
    lastUpdateDate  = json['lastUpdateDate'];
    rut             = json['rut'];
    rutDv           = json['rutDv'];
  }

  Map<String, dynamic> toJson() => {
    'id'              : this.id,
    'name'            : this.name,
    'lastName'        : this.lastName,
    'email'           : this.email,
    'contactNumber'   : this.contactNumber,
    'bithday'         : this.bithday,
    'termsChecked'    : this.termsChecked,
    'location'        : this.location,
    'rut'             : this.rut,
    'rutDv'           : this.rutDv,
  };
}