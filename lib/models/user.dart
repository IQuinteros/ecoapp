import 'package:flutter_ecoapp/models/base.dart';

class UserModel extends BaseModel
{
  DateTime createdDate;

  UserModel({
    required int id,
    required this.createdDate,
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'createdDate' : createdDate
  };
}