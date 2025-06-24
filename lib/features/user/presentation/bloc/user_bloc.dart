import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user.dart';

// Events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentUserEvent extends UserEvent {
  const GetCurrentUserEvent();
}

class UpdateProfileEvent extends UserEvent {
  final String name;
  final String email;
  final String? avatar;

  const UpdateProfileEvent({
    required this.name,
    required this.email,
    this.avatar,
  });

  @override
  List<Object?> get props => [name, email, avatar];
}

// States
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUser getCurrentUser;

  UserBloc({required this.getCurrentUser}) : super(const UserInitial()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  Future<void> _onGetCurrentUser(
    GetCurrentUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await getCurrentUser();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserLoaded(user)),
    );
  }
}
