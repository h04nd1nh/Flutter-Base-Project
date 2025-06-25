import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_base_project/core/error/failures.dart';
import 'package:flutter_base_project/features/user/domain/entities/user.dart';
import 'package:flutter_base_project/features/user/domain/usecases/get_current_user.dart';
import 'package:flutter_base_project/features/user/presentation/bloc/user_bloc.dart';

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

void main() {
  late UserBloc bloc;
  late MockGetCurrentUser mockGetCurrentUser;

  setUp(() {
    mockGetCurrentUser = MockGetCurrentUser();
    bloc = UserBloc(getCurrentUser: mockGetCurrentUser);
  });

  tearDown(() {
    bloc.close();
  });

  final tUser = User(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    avatar: 'https://example.com/avatar.jpg',
    createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
    updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
  );

  test('initial state should be UserInitial', () {
    expect(bloc.state, const UserInitial());
  });

  group('GetCurrentUserEvent', () {
    blocTest<UserBloc, UserState>(
      'should emit [UserLoading, UserLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetCurrentUser()).thenAnswer((_) async => Right(tUser));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetCurrentUserEvent()),
      expect: () => [const UserLoading(), UserLoaded(tUser)],
      verify: (_) {
        verify(() => mockGetCurrentUser());
      },
    );

    blocTest<UserBloc, UserState>(
      'should emit [UserLoading, UserError] when getting data fails',
      build: () {
        when(
          () => mockGetCurrentUser(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetCurrentUserEvent()),
      expect: () => [const UserLoading(), const UserError('Server Error')],
      verify: (_) {
        verify(() => mockGetCurrentUser());
      },
    );

    blocTest<UserBloc, UserState>(
      'should emit [UserLoading, UserError] when network error occurs',
      build: () {
        when(() => mockGetCurrentUser()).thenAnswer(
          (_) async => const Left(NetworkFailure('No internet connection')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetCurrentUserEvent()),
      expect: () => [
        const UserLoading(),
        const UserError('No internet connection'),
      ],
    );
  });
}
