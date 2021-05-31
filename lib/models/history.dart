import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class HistoryModel extends BaseModel
{
  DateTime createdDate;

  HistoryModel({
    required int id,
    required this.createdDate,
  }) : super(id: id);
}

class HistoryDetailModel extends BaseModel
{
  DateTime date;
  bool deleted;

  HistoryDetailModel({
    required int id,
    required this.date,
    required this.deleted
  }) : super(id: id);
}