
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class ArticleAPI extends BaseAPI<ArticleModel>{
  ArticleAPI() : super(
    baseUrl: 'article',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => ArticleModel.fromJsonMap(data)
  );
}

class ArticleFormAPI extends BaseAPI<ArticleForm>{
  ArticleFormAPI() : super(
    baseUrl: 'article_form',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => ArticleForm.fromJsonMap(data)
  );
}
