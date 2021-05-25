import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

class ArticleModel extends BaseModel
{
  String title;
  String description;
  double price;
  int stock;
  DateTime createdDate;
  DateTime lastUpdateDate;
  bool enabled;

  List<PhotoModel> photos;
  ArticleForm form;

  String _tag = '';
  set tag(String newTag) => _tag = this.id.toString() + this.title + newTag;
  String get tag => _tag;

  ArticleModel({
    @required int id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.stock,
    @required this.createdDate,
    @required this.lastUpdateDate,
    @required this.enabled,
    @required this.photos,
    @required this.form
  }) : super(id: id);
  
}

class PhotoModel extends BaseModel
{
  String photoUrl;

  PhotoModel({
    @required int id,
    @required this.photoUrl,
  }) : super(id: id);
}

class EcoIndicator{
  final bool hasRecycledMaterials;
  final bool hasReusTips;
  final bool isRecyclableProduct;

  EcoIndicator({this.hasRecycledMaterials = false, this.hasReusTips = false, this.isRecyclableProduct = false});

  @override
  String toString() {
    return '''
      hasRecycledMaterials  : ${hasRecycledMaterials.toString()}
      hasReusTips           : ${hasReusTips.toString()}
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
  DateTime createdDate;
  DateTime lastUpdateDate;

  ArticleForm({
    @required int id,
    this.recycledMats = '',
    this.recycledMatsDetail = '',
    this.reuseTips = '',
    this.recycledProd = '',
    this.recycledProdDetail = '',
    this.generalDetail = '',
    @required this.createdDate,
    @required this.lastUpdateDate
  }) : super(id: id);

  EcoIndicator getIndicator(){
    bool hasRecycledMats = recycledMats.isNotEmpty;
    bool hasReusedTips = reuseTips.isNotEmpty;
    bool isRecyclable = recycledProd.isNotEmpty;

    return EcoIndicator(
      hasRecycledMaterials: hasRecycledMats,
      hasReusTips: hasReusedTips,
      isRecyclableProduct: isRecyclable
    );
  }
}