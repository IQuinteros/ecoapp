import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class OpinionModel extends BaseModel
{
  int rating;
  String title;
  String content;

  DateTime date;

  OpinionModel({
    required int id,
    required this.rating,
    required this.title,
    this.content = '',
    required this.date,
  }) : super(id: id);
}

class ArticleRating{

  List<OpinionModel> opinions;

  ArticleRating({this.opinions = const []});

  int get count => opinions.length;

  double get avgRating{
    double sum = 0;
    opinions.forEach((element) { sum += element.rating; });
    return sum/opinions.length;
  }

}