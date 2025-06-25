import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/features/user/domain/entities/user.dart';
import 'package:flutter_base_project/features/user/domain/repositories/user_repository.dart';
import 'package:flutter_base_project/features/user/domain/usecases/get_current_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late GetCurrentUser usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetCurrentUser(mockUserRepository);
  });

  final tUser = User(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    avatar: 'https://example.com/avatar.jpg',
    createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
    updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
  );

  group('GetCurrentUser', () {
    test('should get current user from the repository', () async {
      // arrange
      when(
        () => mockUserRepository.getCurrentUser(),
      ).thenAnswer((_) async => Right(tUser));

      // act
      final result = await usecase();

      // assert
      expect(result, Right(tUser));
      verify(() => mockUserRepository.getCurrentUser());
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return server failure when repository fails', () async {
      // arrange
      const tFailure = ServerFailure('Server Error');
      when(
        () => mockUserRepository.getCurrentUser(),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase();

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockUserRepository.getCurrentUser());
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return network failure when no internet connection', () async {
      // arrange
      const tFailure = NetworkFailure('No internet connection');
      when(
        () => mockUserRepository.getCurrentUser(),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase();

      // assert
      expect(result, const Left(tFailure));
    });
  });
}
