import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class OpinionAPI extends BaseAPI<OpinionModel>{
  OpinionAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'opinion',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => OpinionModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}
