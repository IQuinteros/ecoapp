
import 'dart:async';
import 'dart:convert';

import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ecoapp/models/base.dart';
import 'package:http/http.dart';

enum FailConnectReason{
  refused,
  decoding,
  status
}

abstract class BaseAPI<T extends BaseModel>{

  // Hosting: ecomercioweb.000webhostapp.com
  static const String _authority = 'ecomercioweb.000webhostapp.com';//'localhost:8888';
  static const String _requests = 'api/requests';
  static const String _apiKey = 'iyinF635EHL7SF8cmYY6rR9en4uRQjA1';

  final String baseUrl;
  Map<String, dynamic> Function(T) getJsonParams;
  T Function(Map<String, dynamic>) constructor;
  
  final bool DEBUG = true;
  final bool simulateLag = false;

  final Function(FailConnectReason reason)? onFailConnect;
  static Function(FailConnectReason reason)? staticOnFailConnect;

  BaseAPI({required this.baseUrl, required this.getJsonParams, required this.constructor, required this.onFailConnect});

  String _getRequestUrl(String normalName, String? customName) => customName != null? '${baseUrl}_$customName.php' : '${baseUrl}_$normalName.php'; 

  // Process Response
  Future<Map<String, dynamic>> _processResponse(Uri uri, Map<String, dynamic>? params) async{
    if(DEBUG) print('processing ${jsonEncode(params)}');
    if(DEBUG) print('Uri: $uri');
    Response resp;

    if(params == null) params = {};

    try{
      resp = await http.post(
        uri,
        body: jsonEncode(params..addAll({'C8AEA': _apiKey})),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch(e, stacktrace){
      print(e);
      print(stacktrace);
      staticOnFailConnect?.call(FailConnectReason.refused);
      onFailConnect?.call(FailConnectReason.refused);
      return {'success': false};
    }

    if(resp.statusCode != 201 && resp.statusCode != 200){
      staticOnFailConnect?.call(FailConnectReason.status);
      onFailConnect?.call(FailConnectReason.status);
    }

    //if(simulateLag) await Future.delayed(Duration(seconds: 3));
    if(DEBUG) print('querying ${resp.body}');
    try{
      final decodedData = json.decode(resp.body);
      if(DEBUG) print('decoded: $decodedData');
      return decodedData;
    }
    catch(e, stacktrace){
      print(e);
      print(stacktrace);
      staticOnFailConnect?.call(FailConnectReason.decoding);
      onFailConnect?.call(FailConnectReason.decoding);
      return {'success': false};
    }
  }

  // Request
  Future<RequestResult> request(String subUrl, [Map<String, dynamic>? queryParams]) async{
    // HTTP for localhost, HTTPS for hosting
    if(DEBUG) print('REQUEST: $subUrl; PARAMS: $queryParams');
    try{
      final url = Uri.https(_authority, '$_requests/$baseUrl' + '/$subUrl');
      final result = await _processResponse(url, queryParams);
      return RequestResult(result['success'], result['data']);
    }
    catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return RequestResult(false, []);
    }
  }

  // Basic Methods

  // Select items list
  Future<List<T>> selectAll({Map<String, dynamic>? params, String? customName}) async{
    final result = await request(_getRequestUrl('select', customName), params);
    
    if(!result.success) return [];

    List<T> items = [];
    try{
      if(result.data != null){
        result.data!.forEach((value) => items.add(constructor(value)));
      }
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
    if(result.data == null) return null;
    return constructor(Map.fromIterable(result.data!));
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
  Future<InsertResult<T>> insert({required T item, String? customName, Map<String, dynamic> additionalParams = const {}}) async{
    final data = (await request(_getRequestUrl('insert', customName), getJsonParams(item)..addAll(additionalParams))).data;

    if(data == null) return InsertResult<T>();
    
    if(data.length > 0){
      return InsertResult<T>(
        object: item..id = int.parse(data.toList()[0]),
        additionalData: data.toList()
      );
    }

    return InsertResult();
  }

  // Delete method
  Future<bool> delete({required T item, String? customName, Map<String, dynamic> params = const {}}) async => (await request(_getRequestUrl('delete', customName), getJsonParams(item)..addAll(params))).success;

  // Ping
  void ping(Function(bool) result){
    final ping = Ping('google.com', count: 5);

    // Begin ping process and listen for output
    ping.stream.listen((event) {
      print(event);
    });
  }

}

class RequestResult{
  // TODO: API SHOULD RETURN 'success' PARAM

  final bool success;
  final Iterable? data;

  RequestResult(this.success, this.data);
}

class InsertResult <T>{
  final T? object;
  final List additionalData;

  bool get hasData => additionalData.length > 0;

  InsertResult({
    this.object, 
    this.additionalData = const []
  });
}