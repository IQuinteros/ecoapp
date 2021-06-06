import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class CartModel extends BaseModel
{
  List<ArticleModel> articles;

  CartModel({
    required int id,
    this.articles = const [],
  }) : super(id: id);

  double get totalPrice {
    double total = 0;
    articles.forEach((element) { total += element.price; });
    return total;
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'        : id,
    'articles'  : articles
  };

}