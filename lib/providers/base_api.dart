
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_ecoapp/models/base.dart';

abstract class BaseAPI<T extends BaseModel>{

  static const String _authority = 'ecomercioweb.000webhostapp.com';
  static const String _requests = 'api/requests';

  final String baseUrl;
  Map<String, dynamic> Function(T) getJsonParams;
  T Function(Map<String, dynamic>) constructor;
  

  BaseAPI({required this.baseUrl, required this.getJsonParams, required this.constructor});

  // Process Response
  Future<Map<String, dynamic>> _processResponse(Uri uri) async{
    print('processing');
    final resp = await http.get(uri);
    print('querying $resp');
    final decodedData = json.decode(resp.body);

    print('decoded: $decodedData');
    return decodedData;
  }

  // Request
  Future<RequestResult> request(String subUrl, [Map<String, dynamic>? queryParams]) async{
    final url = Uri.https(_authority, '$_requests/$baseUrl' + '/$subUrl', queryParams);
    final result = await _processResponse(url);
    return RequestResult(result['success'], result['data']);
  }

  // Basic Methods

  // Select items list
  Future<List<T>> selectAll([Map<String, dynamic>? params]) async{
    final result = await request('${baseUrl}_select.php', params);
    if(!result.success) return [];

    List<T> items = [];
    try{
      result.data.forEach((value) => items.add(constructor(value)));
    }
    catch (e, stacktrace){
      print('Exception: $e');
      print('Exception: $stacktrace');
    }

    return items;
  }

  // Select only one
  Future<T?> selectOne([Map<String, dynamic>? byParam]) async{
    final result = await request('${baseUrl}_get.php', byParam);
    if(!result.success) return null;
    
    return constructor(Map.fromIterable(result.data));
  }

  // Update method
  Future<T?> update(T actualItem, T newItem) async{
    Map<String, dynamic> params = getJsonParams(newItem);
    params['prev_id'] = actualItem.id;

    final result = await request('${baseUrl}_update.php', params);
    if(!result.success) return null;

    return newItem;
  }

  // Insert method
  Future<T?> insert(T item) async => (await request('${baseUrl}_insert.php', getJsonParams(item))).success? item : null;

  // Delete method
  Future<bool> delete(T item) async => (await request('${baseUrl}_delete.php')).success;

}

class RequestResult{
  // TODO: API SHOULD RETURN 'success' PARAM

  final bool success;
  final Iterable data;

  RequestResult(this.success, this.data);
}