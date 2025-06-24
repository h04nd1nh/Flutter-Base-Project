import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

// part 'user_api_service.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET(ApiEndpoints.profile)
  Future<UserModel> getCurrentUser();

  @PUT(ApiEndpoints.updateProfile)
  Future<UserModel> updateProfile(@Body() Map<String, dynamic> data);

  @GET(ApiEndpoints.posts) // Using posts as example users endpoint
  Future<List<UserModel>> getUsers();

  @DELETE(ApiEndpoints.profile)
  Future<void> deleteAccount();
}

// Temporary implementation until we run build_runner
class _UserApiService implements UserApiService {
  final Dio _dio;

  _UserApiService(this._dio, {String? baseUrl});

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
