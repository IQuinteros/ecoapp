import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class StoreModel extends BaseModel
{
  String publicName;
  String description;
  String email;
  int contactNumber;
  String location;
  int rut;
  String rutDv;
  bool enabled;   
  DateTime createdDate;
  DateTime lastUpdateDate;

  StoreModel({
    @required int id,
    @required this.publicName,
    @required this.description,
    @required this.email,
    @required this.contactNumber,
    @required this.location,
    @required this.rut,
    @required this.rutDv,
    @required this.enabled,
    @required this.createdDate,
    @required this.lastUpdateDate,
  }) : super(id: id);
}