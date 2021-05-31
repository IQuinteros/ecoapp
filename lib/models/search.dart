import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class SearchModel extends BaseModel
{
  String searchText;
  DateTime searchDate;

  SearchModel({
    required int id,
    required this.searchText,
    required this.searchDate
  }) : super(id: id);
}