import 'package:flutter_ecoapp/models/search.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class SearchAPI extends BaseAPI<SearchModel>{
  SearchAPI() : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => SearchModel.fromJsonMap(data)
  );
}
