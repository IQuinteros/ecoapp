import 'package:flutter_ecoapp/models/base.dart';

class UserModel extends BaseModel
{
  late DateTime createdDate;

  UserModel({
    required int id,
    required this.createdDate,
  }) : super(id: id);

  UserModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    createdDate            = json['createdDate'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'createdDate' : createdDate
  };
}