
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/models/store.dart';

class ArticleModel extends BaseModel with TagModel
{
  late String title;
  late String description;
  late int price;
  int? pastPrice;
  late int stock;
  late DateTime createdDate;
  late DateTime lastUpdateDate;
  late bool enabled;
  late int storeId;

  late CategoryModel category;
  late List<PhotoModel> photos;
  late ArticleForm form;
  StoreModel? store;
  late List<QuestionModel> questions;
  late ArticleRating rating;

  bool favorite = false;

  String _tag = '';
  set tag(String newTag) => _tag = this.id.toString() + this.title + newTag;
  String get tag => _tag;

  ArticleModel({
    required int id,
    required this.title,
    required this.description,
    required this.price,
    this.pastPrice,
    required this.stock,
    required this.createdDate,
    required this.lastUpdateDate,
    required this.enabled,
    this.photos = const [],
    required this.form,
    required this.category,
    this.store,
    this.questions = const [],
    required this.rating
  }) : super(id: id){
    initTagging(newID: this.id, newTitle: this.title);
  }

  ArticleModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    title           = json['title'];
    description     = json['description'];
    price           = json['price'];
    pastPrice       = json['past_price'];
    stock           = json['stock'];
    createdDate     = DateTime.parse(json['creation_date']);
    lastUpdateDate  = DateTime.parse(json['last_update_date']);
    enabled         = json['enabled'];
    photos          = json['photos'].map<PhotoModel>((e) => PhotoModel.fromJsonMap(e)).toList() ?? const [];
    category        = CategoryModel.fromJsonMap(json['category']);
    store           = StoreModel.fromJsonMap(json['store']);
    favorite        = json['favorite'] ?? false;

    // Create questions
    questions       = json['questions'].map<QuestionModel>((e) => QuestionModel.fromJsonMap(e)).toList() ?? const [];
    rating          = ArticleRating(opinions: json['opinions'].map<OpinionModel>((e) => OpinionModel.fromJsonMap(e)).toList());
    storeId         = json['store_id'];
    form            = ArticleForm.fromJsonMap(json['form']);
    initTagging(newID: this.id, newTitle: this.title);
  }

  @override
  Map<String, dynamic> toJson() => {
    'title'           : this.title,
    'description'     : this.description,
    'pastPrice'       : this.pastPrice,
    'stock'           : this.stock,
    'enabled'         : this.enabled,
    'photos'          : this.photos,
    'form'            : this.form,
    'category'        : this.category,
    'store'           : this.store,
    'questions'       : this.questions,
    'rating'          : this.rating,
    'createdDate'     : this.createdDate,
    'lastUpdateDate'  : this.lastUpdateDate,
    'store_id'        : this.storeId
  };
  
}

class PhotoModel extends BaseModel
{
  late String photoUrl;

  PhotoModel({
    required int id,
    required this.photoUrl,
  }) : super(id: id);

  PhotoModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    photoUrl          = json['photo'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : this.id,
    'photoUrl'    : this.photoUrl,
  };
}

class EcoIndicator{
  bool hasRecycledMaterials;
  bool hasReuseTips;
  bool isRecyclableProduct;

  EcoIndicator({this.hasRecycledMaterials = false, this.hasReuseTips = false, this.isRecyclableProduct = false});

  @override
  String toString() {
    return '''
      hasRecycledMaterials  : ${hasRecycledMaterials.toString()}
      hasReusTips           : ${hasReuseTips.toString()}
      isRecyclableProduct   : ${isRecyclableProduct.toString()}
    ''';
  }
}

class ArticleForm extends BaseModel
{
  late String recycledMats;
  late String recycledMatsDetail;
  late String reuseTips;
  late String recycledProd;
  late String recycledProdDetail;
  late String generalDetail;
  DateTime? createdDate;
  DateTime? lastUpdateDate;

  bool get hasDetail{
    EcoIndicator indicator = getIndicator();
    return indicator.hasRecycledMaterials || indicator.hasReuseTips || indicator.isRecyclableProduct;
  }

  ArticleForm({
    required int id,
    this.recycledMats = '',
    this.recycledMatsDetail = '',
    this.reuseTips = '',
    this.recycledProd = '',
    this.recycledProdDetail = '',
    this.generalDetail = '',
    required this.createdDate,
    required this.lastUpdateDate
  }) : super(id: id);

  ArticleForm.infoPurchase({
    required int id,
    this.recycledMats = '',
    this.recycledMatsDetail = '',
    this.reuseTips = '',
    this.recycledProd = '',
    this.recycledProdDetail = '',
    this.generalDetail = '',
  }): super(id: id);

  ArticleForm.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    recycledMats          = json['recycled_mats'] ?? '';
    recycledMatsDetail    = json['recycled_mats_detail'] ?? '';
    reuseTips             = json['reuse_tips'] ?? '';
    recycledProd          = json['recycled_prod'] ?? '';
    recycledProdDetail    = json['recycled_prod_detail'] ?? '';
    createdDate           = DateTime.parse(json['creation_date']);
    lastUpdateDate        = DateTime.parse(json['last_update_date']);
    generalDetail         = json['general_detail'] ?? '';
  }

  EcoIndicator getIndicator(){
    bool hasRecycledMats = recycledMats.isNotEmpty;
    bool hasReusedTips = reuseTips.isNotEmpty;
    bool isRecyclable = recycledProd.isNotEmpty;

    return EcoIndicator(
      hasRecycledMaterials: hasRecycledMats,
      hasReuseTips: hasReusedTips,
      isRecyclableProduct: isRecyclable
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'                  : id,
    'recycledMats'        : recycledMats,
    'recycledMatsDetail'  : recycledMatsDetail,
    'reuseTips'           : reuseTips,
    'recycledProd'        : recycledProd,
    'recycledProdDetail'  : recycledProdDetail,
    'generalDetail'       : generalDetail,
    'createdDate'         : createdDate,
    'lastUpdateDate'      : lastUpdateDate,
  };
}