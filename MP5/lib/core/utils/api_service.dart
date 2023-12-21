/*import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://newsapi.org/v2/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required String endPoint,
    required Map<String, dynamic> queryParameters,
  }) async {
    Response response = await _dio.get(
      '$_baseUrl$endPoint',
      queryParameters: queryParameters,
    );
    return response.data;
  }
}*/
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final _baseUrl = 'newsapi.org';
  Future<Map<String, dynamic>> get({
    required String endPoint,
    required Map<String, dynamic> queryParameters,
  }) async {
    var uri = Uri.https(_baseUrl, "v2/$endPoint", queryParameters);
    print(uri);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
