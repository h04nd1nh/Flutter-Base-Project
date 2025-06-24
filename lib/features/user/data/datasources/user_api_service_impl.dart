import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import 'user_api_service.dart';

@LazySingleton(as: UserApiService)
class UserApiServiceImpl implements UserApiService {
  final DioClient _dioClient;

  UserApiServiceImpl(this._dioClient);

  Dio get _dio => _dioClient.client;

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await _dio.get(ApiEndpoints.profile);
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final response = await _dio.put(ApiEndpoints.updateProfile, data: data);
    return UserModel.fromJson(response.data);
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _dio.get(ApiEndpoints.posts);
    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> deleteAccount() async {
    await _dio.delete(ApiEndpoints.profile);
  }
}
