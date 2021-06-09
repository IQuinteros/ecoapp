import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class CartModel extends BaseModel
{
  late List<ArticleModel> articles;

  CartModel({
    required int id,
    this.articles = const [],
  }) : super(id: id);

  double get totalPrice {
    double total = 0;
    articles.forEach((element) { total += element.price; });
    return total;
  }

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

  CartModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    articles = json['articles'] is List? 
      json['articles'].map<ArticleModel>((Map<String, dynamic> e) => ArticleModel.fromJsonMap(e)) 
      : [];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'        : id,
    'articles'  : articles.map<Map<String, dynamic>>((e) => e.toJson()).toList()
  };

}