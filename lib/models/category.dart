import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class CategoryModel extends BaseModel
{
  String title;
  DateTime createdDate;

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
        return Icons.person;
      case 'Alimentos':
        return Icons.food_bank;
      default: return Icons.ac_unit;
    }
  }

  @override
  String toString() => this.title;

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}