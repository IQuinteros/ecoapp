import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/views/article_view.dart';

class OpinionModel extends BaseModel
{
  late int rating;
  late String title;
  late String content;
  late int articleId;

  late DateTime date;

  OpinionModel({
    required int id,
    required this.rating,
    required this.title,
    this.content = '',
    required this.date,
  }) : super(id: id);  

  OpinionModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    rating          = json['rating'];
    title           = json['title'];
    content         = json['content'];
    articleId         = json['article_id'];
    date            = DateTime.parse(json['creation_date']);
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'        : id,
    'rating'    : rating,
    'title'     : title,
    'content'   : content,
    'date'      : date,
  };
}

class ArticleRating{

  List<OpinionModel> opinions;

  ArticleRating({this.opinions = const []});

  int get count => opinions.length;

  double get avgRating{
    double sum = 0;
    opinions.forEach((element) { sum += element.rating; });
    return opinions.length > 0? sum/opinions.length : 0;
  }

}