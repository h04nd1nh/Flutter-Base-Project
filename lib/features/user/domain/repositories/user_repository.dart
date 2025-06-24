import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> updateProfile({
    required String name,
    required String email,
    String? avatar,
  });
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, Unit>> deleteAccount();
}
