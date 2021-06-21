import 'package:flutter_ecoapp/models/history.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class HistoryAPI extends BaseAPI<HistoryModel>{
  HistoryAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'history',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => HistoryModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}

class HistoryDetailAPI extends BaseAPI<HistoryDetailModel>{
  HistoryDetailAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'history_detail',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => HistoryDetailModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}
