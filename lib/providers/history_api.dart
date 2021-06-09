import 'package:flutter_ecoapp/models/history.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class HistoryAPI extends BaseAPI<HistoryModel>{
  HistoryAPI() : super(
    baseUrl: 'history',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => HistoryModel.fromJsonMap(data)
  );
}

class HistoryDetailAPI extends BaseAPI<HistoryDetailModel>{
  HistoryDetailAPI() : super(
    baseUrl: 'history_detail',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => HistoryDetailModel.fromJsonMap(data)
  );
}
