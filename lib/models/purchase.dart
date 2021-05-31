import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class PurchaseModel extends BaseModel
{
  double total;
  DateTime createdDate;

  InfoPurchaseModel info;

  PurchaseModel({
    required int id,
    required this.total,
    required this.createdDate,
    required this.info
  }) : super(id: id);
}

class InfoPurchaseModel extends BaseModel
{
  String names;
  String location;
  String contactNumber;
  String district;

  InfoPurchaseModel({
    required int id,
    required this.names,
    required this.location,
    required this.contactNumber,
    required this.district
  }) : super(id: id);
}