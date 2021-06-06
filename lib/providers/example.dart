
import 'dart:async';
import 'dart:convert';

import 'package:flutter_movies/src/models/actors_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movies/src/models/movie_model.dart';

class MoviesProvider{
  String _apiKey    = '7faa93e88b84c93bd99be57222ae9f51';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';

  int _popularsPage = 0;
  bool _loading = false;
  
  List<Movie> _populars = [];

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;
  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams(){
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri uri) async{
    final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);

    final movies = Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {

    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key'   :  _apiKey,
      'language'  : _language
    });

    return await _processResponse(url);

  }

  Future<List<Movie>> getPopulars() async {

    if(_loading) return [];
    _loading = true;

    _popularsPage++;

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key'   :  _apiKey,
      'language'  : _language,
      'page'      : _popularsPage.toString()
    });

    final resp = await _processResponse(url);

    _populars.addAll(resp);
    popularsSink(_populars);

    _loading = false;
    return resp;
  }

  Future<List<Movie>> searchMovie(String query) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'   :  _apiKey,
      'language'  : _language,
      'query'     : query 
    });

    return await _processResponse(url);

  }

  Future<List<Actor>> getCast(String movieId) async{ 
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key'   :  _apiKey,
      'language'  : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
}