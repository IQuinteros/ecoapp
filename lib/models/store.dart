import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/district.dart';

class StoreModel extends BaseModel with TagModel
{
  String publicName;
  String description;
  String photoUrl = '';
  String email;
  int contactNumber;
  String location;
  int rut;
  String rutDv;
  bool enabled;   
  DateTime createdDate;
  DateTime lastUpdateDate;

  DistrictModel district;

  StoreModel({
    @required int id,
    @required this.publicName,
    @required this.description,
    this.photoUrl = 'https://seeklogo.com/images/F/facebook-marketplace-logo-46A976DABC-seeklogo.com.png',
    @required this.email,
    @required this.contactNumber,
    @required this.location,
    @required this.rut,
    @required this.rutDv,
    @required this.enabled,
    @required this.createdDate,
    @required this.lastUpdateDate,
    @required this.district
  }) : super(id: id){
    initTagging(newID: this.id, newTitle: this.publicName);
  }
}