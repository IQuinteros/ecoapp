import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class CityModel extends BaseModel
{
  String name;

  CityModel({
    @required int id,
    @required this.name,
  }) : super(id: id);
}