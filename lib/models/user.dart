
import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class UserModel extends BaseModel
{
  DateTime creationDate;

  UserModel({
    @required int id,
    @required this.creationDate,
  }) : super(id: id);
}