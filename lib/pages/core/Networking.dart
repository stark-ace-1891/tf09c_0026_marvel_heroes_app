import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class Networking {
  final dio = Dio();

  Networking() {
    dio.options.baseUrl = 'http://gateway.marvel.com';
  }

  Map<String, dynamic> _getApiKeys() {
    final timestamp = DateTime.now();
    const apiKey = 'ffdcc45c51f84e544c30113df9863fc2';
    const privateKey = '53f8e9b1abd0571d6123233a8ff3da5c60d2e37e';
    final concatKeys = '$timestamp$privateKey$apiKey'; //orden si es importante
    final encodeKey = utf8.encode(concatKeys);
    final hash = md5.convert(encodeKey).toString();
    return {
      'ts': timestamp.toString(),
      'apikey': apiKey,
      'hash': hash,
    };
  }

  //GET, POST/PUT, PATCH, DELETE
  Future<Map<String, dynamic>> get({
    required String operationPath,
    Map<String, dynamic>? params,
  }) async {
    Map<String, dynamic> queryParams = {};
    final key = _getApiKeys();
    if (params != null) {
      queryParams.addAll(params);
      queryParams.addAll(key);
    } else {
      queryParams.addAll(key);
    }
    final response = await dio.get(
      operationPath,
      queryParameters: queryParams,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String operationPath, Map<String, dynamic>? params}) async {
    final response = await dio.post(
      operationPath,
      data: params,
    );
    return response.data;
  }
}
