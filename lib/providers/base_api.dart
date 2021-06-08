
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_ecoapp/models/base.dart';

abstract class BaseAPI<T extends BaseModel>{

  static const String _authority = 'localhost';
  static const String _requests = 'ecoweb/api/requests';

  final String baseUrl;
  Map<String, dynamic> Function(T) getJsonParams;
  T Function(Map<String, dynamic>) constructor;
  

  BaseAPI({required this.baseUrl, required this.getJsonParams, required this.constructor});

  String _getRequestUrl(String normalName, String? customName) => customName != null? '${baseUrl}_$customName.php' : '${baseUrl}_$normalName.php'; 

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
    // HTTP for localhost, HTTPS for hosting
    final url = Uri.http(_authority, '$_requests/$baseUrl' + '/$subUrl', queryParams);
    final result = await _processResponse(url);
    return RequestResult(result['success'], result['data']);
  }

  // Basic Methods

  // Select items list
  Future<List<T>> selectAll({Map<String, dynamic>? params, String? customName}) async{
    final result = await request(_getRequestUrl('select', customName), params);
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
  Future<T?> selectOne({Map<String, dynamic>? byParam, String? customName}) async{
    final result = await request(_getRequestUrl('get', customName), byParam);
    if(!result.success) return null;
    return constructor(Map.fromIterable(result.data));
  }

  // Update method
  Future<T?> update({required T item, String? customName}) async{
    Map<String, dynamic> params = getJsonParams(item);
    params['prev_id'] = item.id;

    final result = await request(_getRequestUrl('update', customName), params);
    if(!result.success) return null;

    return item;
  }

  // Insert method
  Future<T?> insert({required T item, String? customName}) async => (await request(_getRequestUrl('insert', customName), getJsonParams(item))).success? item : null;

  // Delete method
  Future<bool> delete({required T item, String? customName}) async => (await request(_getRequestUrl('delete', customName))).success;

}

class RequestResult{
  // TODO: API SHOULD RETURN 'success' PARAM

  final bool success;
  final Iterable data;

  RequestResult(this.success, this.data);
}