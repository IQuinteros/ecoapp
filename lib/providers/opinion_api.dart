import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class OpinionAPI extends BaseAPI<OpinionModel>{
  OpinionAPI() : super(
    baseUrl: 'opinion',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => OpinionModel.fromJsonMap(data)
  );
}
