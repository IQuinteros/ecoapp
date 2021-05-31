import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class UserModel extends BaseModel
{
  DateTime createdDate;

  UserModel({
    required int id,
    required this.createdDate,
  }) : super(id: id);
}