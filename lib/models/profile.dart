
import 'package:flutter/material.dart';

class ProfileModel
{
  int id;
  String name;
  String lastName;
  String email;
  int contactNumber;
  DateTime bithday;
  bool termsChecked;
  String location;
  DateTime creationDate;
  DateTime lastUpdateDate;
  String rut;
  String rutDv;

  ProfileModel({
    @required this.id, 
    @required this.name,
    @required this.lastName,
    @required this.email, 
    @required this.contactNumber,
    @required this.bithday,
    @required this.termsChecked,
    @required this.location,
    @required this.creationDate,
    @required this.lastUpdateDate,
    @required this.rut,
    @required this.rutDv,
  });
}