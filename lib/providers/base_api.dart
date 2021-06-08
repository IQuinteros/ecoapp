
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_ecoapp/models/base.dart';

abstract class BaseAPI<T extends BaseModel>{

  // Hosting: ecomercioweb.000webhostapp.com
  static const String _authority = 'localhost';
  static const String _requests = 'ecoweb/api/requests';

  final String baseUrl;
  Map<String, dynamic> Function(T) getJsonParams;
  T Function(Map<String, dynamic>) constructor;
  

  BaseAPI({required this.baseUrl, required this.getJsonParams, required this.constructor});

  String _getRequestUrl(String normalName, String? customName) => customName != null? '${baseUrl}_$customName.php' : '${baseUrl}_$normalName.php'; 

  // Process Response
  Future<Map<String, dynamic>> _processResponse(Uri uri, Map<String, dynamic>? params) async{
    print('processing ${jsonEncode(params)}');
    final resp = await http.post(
      uri,
      body: jsonEncode(params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('querying ${resp.body}');
    try{
      final decodedData = json.decode(resp.body);
      print('decoded: $decodedData');
      return decodedData;
    }
    catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return {'success': false};
    }

    
    
  }

  // Request
  Future<RequestResult> request(String subUrl, [Map<String, dynamic>? queryParams]) async{
    // HTTP for localhost, HTTPS for hosting
    final url = Uri.http(_authority, '$_requests/$baseUrl' + '/$subUrl');
    final result = await _processResponse(url, queryParams);
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
  Future<T?> update({required T item, String? customName, Map<String, dynamic> additionalParams = const {}}) async{
    Map<String, dynamic> params = getJsonParams(item)..addAll(additionalParams);
    params['prev_id'] = item.id;

    final result = await request(_getRequestUrl('update', customName), params);
    if(!result.success) return null;

    return item;
  }

  // Insert method
  Future<T?> insert({required T item, String? customName, Map<String, dynamic> additionalParams = const {}}) async => (await request(_getRequestUrl('insert', customName), getJsonParams(item)..addAll(additionalParams))).success? item : null;

  // Delete method
  Future<bool> delete({required T item, String? customName}) async => (await request(_getRequestUrl('delete', customName), getJsonParams(item))).success;

}

class RequestResult{
  // TODO: API SHOULD RETURN 'success' PARAM

  final bool success;
  final Iterable data;

  RequestResult(this.success, this.data);
}