import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/store.dart';

class PurchaseModel extends BaseModel
{
  late int total;
  late DateTime createdDate;

  late InfoPurchaseModel? info;

  late List<ArticleToPurchase> articles;

  PurchaseModel({
    required int id,
    required this.total,
    required this.createdDate,
    required this.info,
    required this.articles
  }) : super(id: id);

  EcoIndicator get summaryEcoIndicator {
    EcoIndicator toReturn = EcoIndicator(
      hasRecycledMaterials: false,
      hasReuseTips: false,
      isRecyclableProduct: false
    );
    articles.forEach((element) { 
      if(element.form.getIndicator().hasRecycledMaterials)
        toReturn.hasRecycledMaterials = true;
      if(element.form.getIndicator().hasReuseTips)
        toReturn.hasReuseTips = true;
      if(element.form.getIndicator().isRecyclableProduct)
        toReturn.isRecyclableProduct = true;
    });

    return toReturn;
  }

  Map<StoreModel?, List<ArticleToPurchase>> get storeSortedArticles{
    Map<StoreModel?, List<ArticleToPurchase>> toReturn = {};
    List<StoreModel?> stores = [];

    articles = articles.map((e) {
      bool found = false;
      stores.forEach((element) {
        if(element?.id == e.store?.id){
          found = true;
          e.store = element;
        }
      });
      if(!found) stores.add(e.store);
      return e;
    }).toList();


    articles.forEach((element) { 
      StoreModel? storeToUpdate = element.store;
      toReturn.update(storeToUpdate, (value) => value + [element], ifAbsent: () => [element]);
    }); 
    return toReturn;
  }

  double get realTotal => articles.fold<double>(0, (double value, element) => value += (element.unitPrice * element.quantity));
  double get discount => (realTotal - total) / realTotal * 100;

  PurchaseModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    total               = json['total'];
    createdDate         = DateTime.parse(json['creation_date']);
    info                = json['info_purchase'] != null? InfoPurchaseModel.fromJsonMap(json['info_purchase']) : null;
    articles            = json['articles'].map<ArticleToPurchase>((e) => ArticleToPurchase.fromJsonMap(e)).toList() ?? const [];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'total'       : total,
    'creation_date' : createdDate.toString(),
    'info'        : info!.toJson(),
    'articles'    : articles.map((e) => e.toJson()).toList()
  };
}

class InfoPurchaseModel extends BaseModel
{
  late String names;
  late String location;
  late String contactNumber;
  late String district;

  InfoPurchaseModel({
    required int id,
    required this.names,
    required this.location,
    required this.contactNumber,
    required this.district,
  }) : super(id: id);

  InfoPurchaseModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    names               = json['names'];
    location            = json['location'];
    contactNumber       = json['contact_number'].toString();
    district            = json['district'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'            : id,
    'names'         : names,
    'location'      : location,
    'contact_number' : contactNumber,
    'district'      : district
  };

}

class ArticleToPurchase extends BaseModel
{
  late PurchaseModel purchase;
  late int? articleId;
  StoreModel? store;
  late String title;
  late int unitPrice;
  late int quantity;

  String? photoUrl;

  late ArticleForm form;
  late ArticleModel? article;

  ArticleToPurchase({
    required int id,
    this.articleId,
    this.store,
    required this.title,
    required this.unitPrice,
    required this.quantity,
    this.photoUrl,
    required this.form
  }) : super(id: id);

  ArticleToPurchase.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    articleId           = json['article_id'];
    article             = json['article'] != null? ArticleModel.fromJsonMap(json['article']) : null;
    store               = StoreModel.fromJsonMap(json['store']);
    title               = json['title'];
    unitPrice           = json['unit_price'];
    quantity            = json['quantity'];
    photoUrl            = json['photo_url'];
    
    form = ArticleForm(
      id: 0,
      generalDetail: json['general_detail'] ?? '',
      recycledMats: json['recycled_mats'] ?? '',
      recycledMatsDetail: json['recycled_mats_detail'] ?? '',
      reuseTips: json['reuse_tips'] ?? '',
      recycledProd: json['recycled_prod'] ?? '',
      recycledProdDetail: json['recycled_prod_detail'] ?? '',
      lastUpdateDate: DateTime.now(), // TODO: Same
      createdDate: DateTime.now() // TODO: Maybe can be null
    );
  }

  bool get hasPhotoUrl => photoUrl != null && photoUrl!.isNotEmpty;

  @override
  Map<String, dynamic> toJson() => {
    'id'        : id,
    'article_id': articleId,
    'store_id'     : store?.id ?? 0,
    'title'     : title,
    'unit_price' : unitPrice,
    'quantity'  : quantity,
    'photo_url'  : photoUrl,
    'general_detail': form.generalDetail,
    'recycled_mats': form.recycledMats,
    'recycled_mats_detail': form.recycledMatsDetail,
    'reuse_tips': form.reuseTips,
    'recycled_prod': form.recycledProd,
    'recycled_prod_detail': form.recycledProdDetail,
  };
}