import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

@injectable
class GetCurrentUser extends UseCaseNoParams<User> {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, User>> call() async {
    return await repository.getCurrentUser();
  }
}
