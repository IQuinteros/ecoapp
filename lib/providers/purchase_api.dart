import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';

class PurchaseAPI extends BaseAPI<PurchaseModel>{
  PurchaseAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'purchase',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => PurchaseModel.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}

class ArticlePurchaseAPI extends BaseAPI<ArticleToPurchase>{
  ArticlePurchaseAPI({Function(FailConnectReason)? onFailConnect}) : super(
    baseUrl: 'article_purchase',
    getJsonParams: (item) => item.toJson(),
    constructor: (data) => ArticleToPurchase.fromJsonMap(data),
    onFailConnect: onFailConnect
  );
}