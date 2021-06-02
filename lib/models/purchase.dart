import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/models/opinion.dart';

class PurchaseModel extends BaseModel
{
  double total;
  DateTime createdDate;

  InfoPurchaseModel info;

  List<ArticleToPurchase> articles;

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

}

class ArticleToPurchase extends BaseModel
{
  late PurchaseModel purchase;
  ArticleModel? article;
  String title;
  double unitPrice;
  int quantity;

  String? photoUrl;

  ArticleForm form;

  ArticleToPurchase({
    required int id,
    this.article,
    required this.title,
    required this.unitPrice,
    required this.quantity,
    this.photoUrl,
    required this.form
  }) : super(id: id);

  bool get hasPhotoUrl => photoUrl != null && photoUrl!.isNotEmpty;
}