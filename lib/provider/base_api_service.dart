import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:riverpod_example_app/provider/api_config.dart';

abstract class BaseApiService {
  final http.Client _client;
  
  BaseApiService({http.Client? client}) : _client = client ?? http.Client();
  
  Future<T?> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      log('GET Request to: $endpoint', name: 'BaseApiService');
      
      final response = await _client
          .get(
            Uri.parse('${ApiConfig.baseUrl}$endpoint'),
            headers: ApiConfig.headers,
          )
          .timeout(ApiConfig.connectionTimeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }
  
  Future<T?> post<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      log('POST Request to: $endpoint', name: 'BaseApiService');
      
      final response = await _client
          .post(
            Uri.parse('${ApiConfig.baseUrl}$endpoint'),
            headers: ApiConfig.headers,
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.connectionTimeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }
  
  T? _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    log(
      'Response status: ${response.statusCode}',
      name: 'BaseApiService',
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      log(
        'Response data: $jsonData',
        name: 'BaseApiService',
      );
      return fromJson(jsonData);
    } else if (response.statusCode == 404) {
      log('Resource not found', name: 'BaseApiService');
      return null;
    } else {
      throw ApiException(
        'Failed to fetch data. Status code: ${response.statusCode}',
      );
    }
  }
  
  void _handleError(dynamic error) {
    if (error is ApiException) {
      log('API Error: ${error.message}', name: 'BaseApiService', error: error);
    } else {
      log('Unknown Error: $error', name: 'BaseApiService', error: error);
      throw ApiException(ApiConfig.unknownError);
    }
  }
  
  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
} 