import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class FavoriteModel extends BaseModel
{
  DateTime createdDate;

  FavoriteModel({
    required int id,
    required this.createdDate,
  }) : super(id: id);
}