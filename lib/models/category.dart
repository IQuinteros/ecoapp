import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class CategoryModel extends BaseModel
{
  late String title;
  late DateTime createdDate;

  CategoryModel({
    required int id,
    required this.title,
    required this.createdDate,
  }) : super(id: id);

  IconData getIcon(){
    return getIconOfCategory(this);
  }

  static IconData getIconOfCategory(CategoryModel categoryRef){
    switch(categoryRef.title){
      case 'Hogar':
        return Icons.home;
      case 'Cuidado Personal':
      case 'Cuidado personal':
        return Icons.person;
      case 'Alimentos':
        return Icons.food_bank;
      case 'Ropa':
        return Icons.checkroom_rounded;
      default: return Icons.ac_unit;
    }
  }

  @override
  String toString() => this.title;

  CategoryModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    title           = json['title'];
    createdDate     = DateTime.parse(json['creation_date']);
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}