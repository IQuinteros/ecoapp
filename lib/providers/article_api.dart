
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class ArticleAPI extends BaseAPI<ArticleModel>{
  ArticleAPI() : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => ArticleModel.fromJsonMap(data)
  );
}
