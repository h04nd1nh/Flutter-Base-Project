import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<UserModel> updateProfile({
    required String name,
    required String email,
    String? avatar,
  });
  Future<List<UserModel>> getUsers();
  Future<void> deleteAccount();
}
