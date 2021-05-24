import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class CategoryModel extends BaseModel
{
  String title;
  DateTime createdDate;

  CategoryModel({
    @required int id,
    @required this.title,
    @required this.createdDate,
  }) : super(id: id);
}