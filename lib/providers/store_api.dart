import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class StoreAPI extends BaseAPI<StoreModel>{
  StoreAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'store',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => StoreModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}
