import 'dart:async';

import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/providers/article_api.dart';
import 'package:flutter_ecoapp/providers/sqlite/cart_local_api.dart';

class CartBloc extends BaseBloc<CartArticleModel>{

  final CartLocalAPI cartLocalAPI = CartLocalAPI();
  final ArticleAPI articleAPI = ArticleAPI();

  @override
  Future<void> initializeBloc() async {
    await cartLocalAPI.initialize();
  }

  CartModel loadedCart = CartModel(articles: []);

  Future<CartModel> loadCart({bool onlyLocal = false, required ProfileModel? profile}) async {
    List<CartArticleModel> articles = await cartLocalAPI.select();
    if(articles.length > 0) {
      await loadRemoteArticles(articles, profile);
    }
    else{
      loadedCart.articles = [];
    }
    return loadedCart;
  }

  Future<void> loadRemoteArticles(List<CartArticleModel> cartArticles, ProfileModel? profile) async {
    List<ArticleModel> articleModels = await articleAPI.selectAll(
      params: {
        'id_list': _getIdsFromArticles(cartArticles),
      }..addAll(profile != null? {'profile_id': profile.id} : {})
    );

    // Update articles
    articleModels.forEach((remoteArticle) { 
      cartArticles.forEach((loadedArticle) {
        if(remoteArticle.id == loadedArticle.articleId){
          loadedArticle.article = remoteArticle;
          loadedArticle.quantity = loadedArticle.quantity.clamp(0, remoteArticle.stock).toInt();
        }
      });
    });
    loadedCart.articles = cartArticles.where((element) => element.article != null).toList();
  }

  Future<List<CartArticleModel>> getCartArticles() async {
    // TODO: remove delayed
    await Future.delayed(Duration(seconds: 2));
    return await cartLocalAPI.select();
  }

  Future<CartArticleModel?> addArticleToCart(ArticleModel article) async {
    final prelist = (await cartLocalAPI.select()).where((element) => element.articleId == article.id).toList();
    if(prelist.length > 0) return prelist[0];
    await cartLocalAPI.insert(
      CartArticleModel(
        articleId: article.id,
        quantity: 1,
      )
    );
    final list = (await cartLocalAPI.select()).where((element) => element.articleId == article.id).toList(); 

    if(list.length <= 0) return null;
    return list[0];
  }

  Map<ArticleModel, Timer?> _updateArticleTimer = {};
  Future<CartArticleModel?> updateArticleToCartTimer(ArticleModel article, int newQuantity, {required ProfileModel? profile}) async {
    if(_updateArticleTimer[article] != null && _updateArticleTimer[article]!.isActive) _updateArticleTimer[article]!.cancel();

    _updateArticleTimer[article] = Timer(Duration(milliseconds: 100), () {
      updateArticleToCart(article, newQuantity, profile: profile);
      _updateArticleTimer[article] = null;
    });
  }

  Future<void> updateArticleToCart(ArticleModel article, int quantity, {required ProfileModel? profile}) async {
    final list = (await cartLocalAPI.select()).where((element) => element.articleId == article.id).toList();
    if(list.length <= 0) return;
    final item = list[0];

    await cartLocalAPI.update(
      item..quantity = quantity
    );
    //await loadCart(onlyLocal: true, profile: profile);
  }

  Future<bool> articleExistsInCart(ArticleModel article) async => (await cartLocalAPI.select()).where((element) => element.articleId == article.id).length > 0;

  Future<void> removeArticleToCart(ArticleModel article, {required ProfileModel? profile}) async {
    await cartLocalAPI.delete(0, custom: { 'article_id': article.id });
    await loadCart(onlyLocal: true, profile: profile);
  }

  Future<void> clearCart() async{
    await cartLocalAPI.clear();
    loadedCart = CartModel(articles: []);
  }

  List<int> _getIdsFromArticles(List<CartArticleModel> articles) => articles.map<int>((e) => e.articleId).toList();
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}