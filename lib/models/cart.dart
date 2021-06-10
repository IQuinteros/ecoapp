import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class CartModel
{
  final List<ArticleModel> articles;

  CartModel({
    this.articles = const [],
  });

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
}

class CartArticleModel extends BaseModel{
  late int articleId;
  late int quantity;

  CartArticleModel({
    required this.articleId,
    required this.quantity
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