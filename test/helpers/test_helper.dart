import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_base_project/core/network/network_info.dart';
import 'package:flutter_base_project/features/user/data/datasources/user_api_service.dart';
import 'package:flutter_base_project/features/user/domain/entities/user.dart';
import 'package:flutter_base_project/features/user/domain/repositories/user_repository.dart';
import 'package:flutter_base_project/features/user/domain/usecases/get_current_user.dart';
import 'package:flutter_base_project/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_base_project/root/presentation/cubit/root_cubit.dart';

// Domain mocks
class MockUserRepository extends Mock implements UserRepository {}

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

// Data mocks
class MockUserApiService extends Mock implements UserApiService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

// Presentation mocks
class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class MockRootCubit extends MockCubit<RootState> implements RootCubit {}

// Test data
class TestData {
  static final testUser = User(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    avatar: 'https://example.com/avatar.jpg',
    createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
    updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
  );

  static final testUsers = [testUser];

  static User createTestUser({
    int id = 1,
    String name = 'Test User',
    String email = 'test@example.com',
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      createdAt: createdAt ?? DateTime.parse('2024-01-01T00:00:00.000Z'),
      updatedAt: updatedAt ?? DateTime.parse('2024-01-01T00:00:00.000Z'),
    );
  }
}
