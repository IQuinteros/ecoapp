import 'dart:async';

import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/providers/article_api.dart';
import 'package:flutter_ecoapp/providers/sqlite/cart_local_api.dart';

class CartBloc extends BaseBloc<CartArticleModel>{

  final CartLocalAPI cartLocalAPI = CartLocalAPI();
  final ArticleAPI articleAPI = ArticleAPI();

  @override
  Future<void> initializeBloc() async {
    await cartLocalAPI.initialize();
  }

  Future<CartModel> getCart() async {
    List<CartArticleModel> articles = await cartLocalAPI.select();
    List<ArticleModel> articleModels = await articleAPI.selectAll(
      params: {
        'ids': _getIdsFromArticles(articles)
      }
    );

    return CartModel(
      articles: articleModels
    );
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
  Future<CartArticleModel?> updateArticleToCart(ArticleModel article, int newQuantity) async {
    if(_updateArticleTimer[article] != null && _updateArticleTimer[article]!.isActive) _updateArticleTimer[article]!.cancel();

    _updateArticleTimer[article] = Timer(Duration(seconds: 5), () {
      _updateArticleToCart(article, newQuantity);
      _updateArticleTimer[article] = null;
    });
  }

  Future<CartArticleModel?> _updateArticleToCart(ArticleModel article, int quantity) async {
    final item = (await cartLocalAPI.select()).where((element) => element.articleId == article.id).toList()[0];
    await cartLocalAPI.update(
      item..quantity = quantity
    );
    final list = (await cartLocalAPI.select()).where((element) => element.articleId == article.id).toList(); 
    if(list.length <= 0) return null;
    return list[0];
  }

  Future<bool> articleExistsInCart(ArticleModel article) async => (await cartLocalAPI.select()).where((element) => element.articleId == article.id).length > 0;

  Future<void> removeArticleToCart(ArticleModel article) async {
    final list = (await cartLocalAPI.select()).where((element) => element.articleId == article.id).toList();
    if(list.length <= 0) return;
    final item = list[0];
    await cartLocalAPI.delete(item.id);
  }

  List<int> _getIdsFromArticles(List<CartArticleModel> articles) => articles.map<int>((e) => e.articleId).toList();
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}