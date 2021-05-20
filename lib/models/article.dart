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

  ArticleModel({
    @required int id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.stock,
    @required this.createdDate,
    @required this.lastUpdateDate,
    @required this.enabled
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

class ArticleForm extends BaseModel
{
  String recycledMats;
  String recycledMatsDetail;
  String reuseTips;
  String recycledProd;
  String recycledProdDetail;
  DateTime createdDate;
  DateTime lastUpdateDate;

  ArticleForm({
    @required int id,
    @required this.recycledMats,
    @required this.recycledMatsDetail,
    @required this.reuseTips,
    @required this.recycledProd,
    @required this.recycledProdDetail,
    @required this.createdDate,
    @required this.lastUpdateDate
  }) : super(id: id);
}