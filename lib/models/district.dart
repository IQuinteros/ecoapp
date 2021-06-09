import 'package:flutter_ecoapp/models/base.dart';

class DistrictModel extends BaseModel
{
  late String name;

  DistrictModel({
    required int id,
    required this.name,
  }) : super(id: id);

  @override
  String toString() => this.name;

  DistrictModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    name           = json['name'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'  : id,
    'name': name
  };
}