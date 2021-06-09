import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/models/question.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/models/user.dart';
import 'package:flutter_ecoapp/providers/article_api.dart';
import 'package:flutter_ecoapp/providers/opinion_api.dart';
import 'package:flutter_ecoapp/providers/question_api.dart';
import 'package:flutter_ecoapp/providers/store_api.dart';

class ArticleBloc extends BaseBloc<ArticleModel>{

  final articleAPI = ArticleAPI();
  final opinionAPI = OpinionAPI();
  final questionAPI = QuestionAPI();
  final storeAPI = StoreAPI();
  final articleFormAPI = ArticleFormAPI();

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

  Future<List<QuestionModel>> getQuestionsFromArticle(ArticleModel article) async => await questionAPI.selectAll(params: {
    'article': article.id
  });

  Future<bool> newQuestionToArticle({
    required ArticleModel article,
    required ProfileModel profile,
    required QuestionModel question
  }) async => (await questionAPI.insert(
    item: question,
    additionalParams: {
      'article': article.id,
      'profile': profile.id
    }
  )) != null;

  Future<StoreModel?> getStoreOfArticle(ArticleModel article) async {
    final stores = await storeAPI.selectAll(params: {
      'article': article.id
    });

    if(stores.length > 0)
      return stores[0];
    
    return null;
  }

  Future<ArticleForm?> getArticleForm(ArticleModel article) async {
    final forms = await articleFormAPI.selectAll(
      params: {
        'article': article.id
      }
    );

    if(forms.length > 0)
      return forms[0];
    return null;
  }
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}