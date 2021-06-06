
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/models/store.dart';

class ArticleModel extends BaseModel with TagModel
{
  late String title;
  late String description;
  late double price;
  double? pastPrice;
  late int stock;
  late DateTime createdDate;
  late DateTime lastUpdateDate;
  late bool enabled;

  late CategoryModel category;
  late List<PhotoModel> photos;
  late ArticleForm form;
  StoreModel? store;
  late List<QuestionModel> questions;
  late ArticleRating rating;

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
    pastPrice       = json['pastPrice'];
    stock           = json['stock'];
    createdDate     = json['createdDate'];
    lastUpdateDate  = json['lastUpdateDate'];
    enabled         = json['enabled'];
    photos          = json['photos'];
    form            = json['form'];
    category        = json['category'];
    store           = json['store'];
    questions       = json['questions'];
    rating          = json['rating'];
  }
  
}

class PhotoModel extends BaseModel
{
  String photoUrl;

  PhotoModel({
    required int id,
    required this.photoUrl,
  }) : super(id: id);
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
  String recycledMats;
  String recycledMatsDetail;
  String reuseTips;
  String recycledProd;
  String recycledProdDetail;
  String generalDetail;
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
}