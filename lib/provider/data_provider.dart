import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_example_app/model/datamodel.dart';
import 'package:riverpod_example_app/provider/api_config.dart';
import 'package:riverpod_example_app/provider/base_api_service.dart';

/// API Service provider that provides a singleton instance of UserApiService
final apiServiceProvider = Provider<UserApiService>((ref) => UserApiService());

/// Data provider that fetches user data
final dataProvider = FutureProvider<UserModel?>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchUser();
});

/// User-specific API service
class UserApiService extends BaseApiService {
  Future<UserModel?> fetchUser() async {
    return get<UserModel>(
      endpoint: ApiConfig.users,
      fromJson: UserModel.fromJson,
    );
  }
  
  Future<List<UserModel>> fetchUsers() async {
    // Example of fetching multiple users
    final response = await get<List<dynamic>>(
      endpoint: '${ApiConfig.users}?size=10',
      fromJson: (json) => json as List<dynamic>,
    );
    
    return response?.map((user) => UserModel.fromJson(user)).toList() ?? [];
  }
  
  Future<UserModel?> createUser(Map<String, dynamic> userData) async {
    return post<UserModel>(
      endpoint: ApiConfig.users,
      body: userData,
      fromJson: UserModel.fromJson,
    );
  }
}

/// Custom exception for API-related errors
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}