import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class PurchaseModel extends BaseModel
{
  double total;
  DateTime createdDate;

  PurchaseModel({
    @required int id,
    @required this.total,
    @required this.createdDate,
  }) : super(id: id);
}

class InfoPurchaseModel extends BaseModel
{
  String names;
  String location;
  String contactNumber;
  String comuna;

  InfoPurchaseModel({
    @required int id,
    @required this.names,
    @required this.location,
    @required this.contactNumber,
    @required this.comuna
  }) : super(id: id);
}