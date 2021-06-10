import 'package:flutter_ecoapp/models/base.dart';

class UserModel extends BaseModel
{
  late DateTime createdDate;

  UserModel({
    required int id,
    required this.createdDate,
  }) : super(id: id);

  UserModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    createdDate            = DateTime.parse(json['creation_date']);
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'creation_date' : createdDate.toString()
  };
}