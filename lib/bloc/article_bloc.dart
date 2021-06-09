import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/article_api.dart';
import 'package:flutter_ecoapp/providers/opinion_api.dart';

class ArticleBloc extends BaseBloc<ArticleModel>{

  final articleAPI = ArticleAPI();
  final opinionAPI = OpinionAPI();

  ArticleBloc(initialState) : super(initialState);

  Future<List<ArticleModel>> getArticlesFromSearch(String search, UserModel user) async => await articleAPI.selectAll(params: {
    'search': search,
    'user': user.id
  });

  Future<List<OpinionModel>> getOpinionsFromArticle(ArticleModel article) async => await opinionAPI.selectAll(params: {
    'article': article.id
  });

  Future<bool> newOpinionToArticle({
    required ArticleModel article, 
    required ProfileModel profile,
    required OpinionModel opinion,
  }) async => (await opinionAPI.insert(
    item: opinion,
    additionalParams: {
      'article': article.id,
      'profile': profile.id
    }
  )) != null;
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}