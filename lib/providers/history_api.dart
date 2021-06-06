import 'package:flutter_ecoapp/models/history.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class HistoryAPI extends BaseAPI<HistoryModel>{
  HistoryAPI() : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => HistoryModel.fromJsonMap(data)
  );
}
