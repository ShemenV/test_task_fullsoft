
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/auth/domain/repositories/repositories.dart';
import 'package:test_task/features/auth/presentation/state/auth_state.dart';
import 'package:test_task/features/core/core.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final UserRepositoryI _repository;

  CancelToken? _cancelToken;

  AuthCubit(this._repository) : super(AuthState()){
    _checkAuth();
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  Future<void> _checkAuth() async {
    emit(state.copyWith(isLoading: true));

    final userId = await _repository.getCurrentUserId();

    if (userId != null) {
      emit(state.copyWith(
        isAuthenticated: true,
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
        isAuthenticated: false,
        isLoading: false,
      ));
    }
  }

  Future<void> login() async {
    emit(state.copyWith(isLoading: true));
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    try{
      final user = await _repository.getUserByEmail(state.email, cancelToken: _cancelToken);
      emit(state.copyWith(isAuthenticated: true));
    }
    on UserNotFoundException catch(error, stack){
      emit(state.copyWith(errorMessage: "Неверный email"));
    }
    catch(error, stack){
     emit(state.copyWith(errorMessage: "Неизвестная ошибка"));
    }
    finally {
      emit(state.copyWith(isLoading: false,));
    }
  }
}
