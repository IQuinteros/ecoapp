import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class DistrictModel extends BaseModel
{
  String name;

  DistrictModel({
    required int id,
    required this.name,
  }) : super(id: id);
}