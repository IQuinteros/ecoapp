import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class PurchaseAPI extends BaseAPI<PurchaseModel>{
  PurchaseAPI() : super(
    baseUrl: 'profile',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => PurchaseModel.fromJsonMap(data)
  );
}
