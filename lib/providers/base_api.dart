
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_ecoapp/models/base.dart';

abstract class BaseAPI<T extends BaseModel>{

  static const String _baseWebUrl = 'url.com/api/requests';

  String baseUrl;
  Map<String, dynamic> Function(T) getJsonParams;
  T Function(Map<String, dynamic>) constructor;
  

  BaseAPI({required this.baseUrl, required this.getJsonParams, required this.constructor});

  String get fullUrl => '$_baseWebUrl/$baseUrl';

  // Process Response
  Future<Map<String, dynamic>> _processResponse(Uri uri) async{
    final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);

    return decodedData;
  }

  // Request
  Future<RequestResult> request(String subUrl, [Map<String, dynamic>? queryParams]) async{
    final url = Uri.https(fullUrl, '/$subUrl', queryParams);

    final result = await _processResponse(url);
    return RequestResult(result['success'], result['data']);
  }

  // Basic Methods

  // Select items list
  Future<List<T>?> selectAll([Map<String, dynamic>? params]) async{
    final result = await request('get_all.php', params);
    if(!result.success) return null;

    List<T> items = [];
    result.data.forEach((key, value) => items.add(constructor(value)));
    return items;
  }

  // Select only one
  Future<T?> selectOne([Map<String, dynamic>? byParam]) async{
    final result = await request('get.php', byParam);
    if(!result.success) return null;

    return constructor(result.data);
  }

  // Update method
  Future<T?> update(T actualItem, T newItem) async{
    Map<String, dynamic> params = getJsonParams(newItem);
    params['prev_id'] = actualItem.id;

    final result = await request('update.php', params);
    if(!result.success) return null;

    return newItem;
  }

  // Insert method
  Future<T?> insert(T item) async => (await request('insert.php', getJsonParams(item))).success? item : null;

  // Delete method
  Future<bool> delete(T item) async => (await request('delete.php')).success;

}

class RequestResult{
  // TODO: API SHOULD RETURN 'sucess' PARAM

  final bool success;
  final Map<String, dynamic> data;

  RequestResult(this.success, this.data);
}