import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/question.dart';

class StoreModel extends BaseModel with TagModel
{
  late String publicName;
  late String description;
  late String photoUrl = '';
  late String email;
  late int contactNumber;
  late String location;
  late int rut;
  late String rutDv;
  late bool enabled;   
  late DateTime createdDate;
  late DateTime lastUpdateDate;

  late DistrictModel district;

  late ArticleRating rating;

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
    //required this.district
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

  StoreModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    publicName          = json['public_name'];
    description         = json['description'];
    photoUrl            = json['photo_url'] ?? 'https://seeklogo.com/images/F/facebook-marketplace-logo-46A976DABC-seeklogo.com.png';
    email               = json['email'];
    contactNumber       = json['contact_number'];
    location            = json['location'];
    rut                 = json['rut'];
    rutDv               = json['rut_cd'].toString();
    enabled             = json['enabled'] != 0;
    createdDate         = DateTime.parse(json['creation_date']);
    lastUpdateDate      = DateTime.parse(json['last_update_date']);
    district            = DistrictModel(
      id:                 json['district_id'], 
      name:               json['district_name']
    );
    rating              = ArticleRating(opinions: json['opinions'].map<OpinionModel>((e) => OpinionModel.fromJsonMap(e)).toList());
    initTagging(newID: this.id, newTitle: this.publicName);
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'            : id,
    'public_name'    : publicName,
    'description'   : description,
    'photo_url'      : photoUrl,
    'email'         : email,
    'contact_number' : contactNumber,
    'location'      : location,
    'rut'           : rut,
    'rut_cd'         : rutDv,
    'enabled'       : enabled,
    'created_date'   : createdDate,
    'last_update__date': lastUpdateDate,
    //'district'      : district,
  };

}