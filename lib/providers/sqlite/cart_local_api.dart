import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/providers/sqlite/base_local_api.dart';

class CartLocalAPI extends BaseLocalAPI<CartModel>{

  CartLocalAPI() : super(
    constructor: (value) => CartModel.fromJsonMap(value),
    toMapFunction: (item) => item.toSqliteParams(),
    params: 'id INTEGER PRIMARY KEY, articles TEXT',
    tableName: 'profile'
  );

}