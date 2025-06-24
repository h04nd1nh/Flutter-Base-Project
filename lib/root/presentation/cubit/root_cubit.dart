import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

// State
class RootState extends Equatable {
  final int currentIndex;

  const RootState({this.currentIndex = 0});

  RootState copyWith({int? currentIndex}) {
    return RootState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object> get props => [currentIndex];
}

// Cubit
@injectable
class RootCubit extends Cubit<RootState> {
  RootCubit() : super(const RootState());

  void changeTab(int index) {
    if (index != state.currentIndex) {
      emit(state.copyWith(currentIndex: index));
    }
  }

  void resetToHome() {
    emit(state.copyWith(currentIndex: 0));
  }
}
