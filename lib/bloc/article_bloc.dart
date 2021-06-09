import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/providers/article_api.dart';

class ArticleBloc extends BaseBloc<ArticleModel>{

  final articleAPI = ArticleAPI();

  ArticleBloc(initialState) : super(initialState);

  Future<List<ArticleModel>> getArticlesFromSearch(String search) async => await articleAPI.selectAll(params: {
    'search': search
  });
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}