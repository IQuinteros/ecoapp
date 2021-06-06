import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';

class StoreModel extends BaseModel with TagModel
{
  String publicName;
  String description;
  String photoUrl = '';
  String email;
  int contactNumber;
  String location;
  int rut;
  String rutDv;
  bool enabled;   
  DateTime createdDate;
  DateTime lastUpdateDate;

  DistrictModel district;

  StoreModel({
    required int id,
    required this.publicName,
    required this.description,
    this.photoUrl = 'https://seeklogo.com/images/F/facebook-marketplace-logo-46A976DABC-seeklogo.com.png',
    required this.email,
    required this.contactNumber,
    required this.location,
    required this.rut,
    required this.rutDv,
    required this.enabled,
    required this.createdDate,
    required this.lastUpdateDate,
    required this.district
  }) : super(id: id){
    initTagging(newID: this.id, newTitle: this.publicName);
  }

  List<ArticleModel> get articles => [ // TODO: Only debug items
    ArticleModel(
      id: 1, 
      title: 'Example', 
      description: 'HOLAH HOL', 
      price: 12, 
      stock: 34, 
      createdDate: createdDate, 
      lastUpdateDate: lastUpdateDate, 
      enabled: enabled, 
      form: ArticleForm(
        createdDate: createdDate,
        id: 1,
        lastUpdateDate: lastUpdateDate,
        generalDetail: '',
        recycledMats: '',
        recycledMatsDetail: '',
        recycledProd: '',
        recycledProdDetail: '',
        reuseTips: ''
      ), 
      category: CategoryModel(createdDate: createdDate, id: 1, title: 'Hogar'), 
      rating: ArticleRating(
        opinions: [
          OpinionModel(
            date: createdDate,
            id: 2,
            rating: 3,
            title: 'Hola hola',
            content: 'COntent fsdkfsdk'
          )
        ]
      )
    ),
    ArticleModel(
      id: 1, 
      title: 'Example', 
      description: 'HOLAH HOL', 
      price: 12, 
      stock: 34, 
      createdDate: createdDate, 
      lastUpdateDate: lastUpdateDate, 
      enabled: enabled, 
      form: ArticleForm(
        createdDate: createdDate,
        id: 1,
        lastUpdateDate: lastUpdateDate,
        generalDetail: '',
        recycledMats: '',
        recycledMatsDetail: '',
        recycledProd: '',
        recycledProdDetail: '',
        reuseTips: ''
      ), 
      category: CategoryModel(createdDate: createdDate, id: 1, title: 'Hogar'), 
      rating: ArticleRating(
        opinions: [
          OpinionModel(
            date: createdDate,
            id: 2,
            rating: 4,
            title: 'Hola  sdfasdf asdf asdf ',
            content: 'COntent asdf asdf asdf asdf asd '
          )
        ]
      )
    )
  ]; // TODO Connect with api

  List<OpinionModel> get allOpinions => articles.map((e) => e.rating.opinions).toList().fold([], (value, element) => value + element);

  @override
  Map<String, dynamic> toJson() => {
    'id'            : id,
    'publicName'    : publicName,
    'description'   : description,
    'photoUrl'      : photoUrl,
    'email'         : email,
    'contactNumber' : contactNumber,
    'location'      : location,
    'rut'           : rut,
    'rutDv'         : rutDv,
    'enabled'       : enabled,
    'createdDate'   : createdDate,
    'lastUpdateDate': lastUpdateDate,
    'district'      : district,
  };

}