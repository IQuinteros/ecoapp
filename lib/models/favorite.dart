import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class FavoriteModel extends BaseModel
{
  late DateTime createdDate;
  late int articleId;
  late ArticleModel article;

  FavoriteModel({
    required int id,
    required this.articleId,
    required this.createdDate,
  }) : super(id: id);

  FavoriteModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    createdDate           = DateTime.parse(json['creation_date']);
    articleId               = json['article_id'];
    article               = ArticleModel.fromJsonMap(json['article'])..favorite = true;
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'article_id'     : articleId,
    'creation_date' : createdDate.toString()
  };
}