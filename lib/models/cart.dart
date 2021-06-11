import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class CartModel
{
  final List<CartArticleModel> articles;

  CartModel({
    this.articles = const [],
  });

  double get totalPrice {
    double total = 0;
    articles.forEach((element) { 
      if(element.article != null){
        total += element.article!.price * element.quantity; 
      }
    });
    return total;
  }

  EcoIndicator get summaryEcoIndicator {
    EcoIndicator toReturn = EcoIndicator(
      hasRecycledMaterials: false,
      hasReuseTips: false,
      isRecyclableProduct: false
    );
    articles.forEach((element) { 
      if(element.article != null){
        if(element.article!.form.getIndicator().hasRecycledMaterials)
          toReturn.hasRecycledMaterials = true;
        if(element.article!.form.getIndicator().hasReuseTips)
          toReturn.hasReuseTips = true;
        if(element.article!.form.getIndicator().isRecyclableProduct)
          toReturn.isRecyclableProduct = true;
      }
    });

    return toReturn;
  }
}

class CartArticleModel extends BaseModel{
  late int articleId;
  late int quantity;
  ArticleModel? article;

  CartArticleModel({
    required this.articleId,
    required this.quantity,
    this.article
  }) : super(id: 0);

  CartArticleModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    articleId = json['article_id'];
    quantity  = json['quantity'];
  }

  @override
  Map<String, dynamic> toJson() => {
    //'id'            : null,
    'article_id'    : articleId,
    'quantity'      : quantity
  };

}