import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/providers/sqlite/base_local_api.dart';

class CartLocalAPI extends BaseLocalAPI<CartArticleModel>{

  CartLocalAPI() : super(
    constructor: (value) => CartArticleModel.fromJsonMap(value),
    toMapFunction: (item) => item.toSqliteParams(),
    // Save articles id and quantity
    params: 'id INTEGER PRIMARY KEY AUTOINCREMENT, article_id INTEGER, quantity INTEGER',
    tableName: 'cart'
  );

}