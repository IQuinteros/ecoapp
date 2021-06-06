import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/category.dart';

class OpinionModel extends BaseModel
{
  late int rating;
  late String title;
  late String content;

  late DateTime date;

  OpinionModel({
    required int id,
    required this.rating,
    required this.title,
    this.content = '',
    required this.date,
  }) : super(id: id);

  // TODO: Connect with api. Only debug 
  ArticleModel get article => ArticleModel(
    id: 202, 
    title: 'Example', 
    description: 'HOLAH HOL', 
    price: 12, 
    stock: 34, 
    createdDate: DateTime.now(), 
    lastUpdateDate: DateTime.now(), 
    enabled: true, 
    form: ArticleForm(
      createdDate: DateTime.now(),
      id: 1,
      lastUpdateDate: DateTime.now(),
      generalDetail: '',
      recycledMats: '',
      recycledMatsDetail: '',
      recycledProd: '',
      recycledProdDetail: '',
      reuseTips: ''
    ), 
    category: CategoryModel(createdDate: DateTime.now(), id: 1, title: 'Hogar'), 
    rating: ArticleRating(
      opinions: [
        OpinionModel(
          date: DateTime.now(),
          id: 2,
          rating: 3,
          title: 'Hola hola',
          content: 'COntent fsdkfsdk'
        )
      ]
    )
  );
  

  OpinionModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    rating          = json['rating'];
    title           = json['title'];
    content         = json['content'];
    date            = json['date'];
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
    return sum/opinions.length;
  }

}