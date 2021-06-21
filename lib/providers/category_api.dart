import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class CategoryAPI extends BaseAPI<CategoryModel>{
  CategoryAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'category',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => CategoryModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}
