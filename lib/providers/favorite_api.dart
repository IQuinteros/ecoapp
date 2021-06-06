import 'package:flutter_ecoapp/models/favorite.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class FavoriteAPI extends BaseAPI<FavoriteModel>{
  FavoriteAPI() : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => FavoriteModel.fromJsonMap(data)
  );
}
