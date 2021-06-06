
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_ecoapp/models/base.dart';

abstract class BaseAPI<T extends BaseModel>{

  String baseUrl;

  BaseAPI({required this.baseUrl});

  // Process Response
  Future<Map<String, dynamic>> _processResponse(Uri uri) async{
    final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);

    return decodedData;
  }

  // Request
  Future<Map<String, dynamic>> request(String subUrl, [Map<String, dynamic>? queryParams]) async{
    final url = Uri.https(baseUrl, subUrl, queryParams);

    return await _processResponse(url);
  }

  // Basic Methods
  Future<List<T>> select_all([dynamic byParam]);
  Future<T> select_one(dynamic byParam);
  Future<T> update(T actualItem, T newItem);
  Future<bool> remove(T item);
  Future<T> insert(T item);

}