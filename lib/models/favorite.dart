import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class FavoriteModel extends BaseModel
{
  DateTime createdDate;
  ArticleModel article;

  FavoriteModel({
    required int id,
    required this.article,
    required this.createdDate,
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'article'     : article,
    'createdDate' : createdDate
  };
}