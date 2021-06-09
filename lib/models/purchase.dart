import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/chat.dart';
import 'package:flutter_ecoapp/models/store.dart';

class PurchaseModel extends BaseModel
{
  late double total;
  late DateTime createdDate;

  late InfoPurchaseModel info;

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
    articles.forEach((element) { 
      StoreModel? storeToUpdate = element.article != null? element.article!.store : element.store;
      toReturn.update(storeToUpdate, (value) => value + [element], ifAbsent: () => [element]);
    }); 
    return toReturn;
  }

  ChatModel get chat {  // TODO: Connect with api
    return ChatModel(
      id: 1,
      createdDate: createdDate,
      closed: false
    );
  }

  double get realTotal => articles.fold<double>(0, (double value, element) => value += (element.unitPrice * element.quantity));
  double get discount => (realTotal - total) / realTotal * 100;

  PurchaseModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    total               = json['total'];
    createdDate         = json['createdDate'];
    info                = json['info'];
    articles            = json['articles'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'total'       : total,
    'createdDate' : createdDate,
    'info'        : info,
    'articles'    : articles
  };
}

class InfoPurchaseModel extends BaseModel
{
  String names;
  String location;
  String contactNumber;
  String district;

  InfoPurchaseModel({
    required int id,
    required this.names,
    required this.location,
    required this.contactNumber,
    required this.district,
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id'            : id,
    'names'         : names,
    'location'      : location,
    'contactNumber' : contactNumber,
    'district'      : district
  };

}

class ArticleToPurchase extends BaseModel
{
  late PurchaseModel purchase;
  ArticleModel? article;
  StoreModel? store;
  String title;
  double unitPrice;
  int quantity;

  String? photoUrl;

  ArticleForm form;

  ArticleToPurchase({
    required int id,
    this.article,
    this.store,
    required this.title,
    required this.unitPrice,
    required this.quantity,
    this.photoUrl,
    required this.form
  }) : super(id: id);

  bool get hasPhotoUrl => photoUrl != null && photoUrl!.isNotEmpty;

  @override
  Map<String, dynamic> toJson() => {
    'id'        : id,
    'article'   : article,
    'store'     : store,
    'title'     : title,
    'unitPrice' : unitPrice,
    'quantity'  : quantity,
    'photoUrl'  : photoUrl,
    'form'      : form,

  };
}