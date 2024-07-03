import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/account/data/repository/auth_repository_interface.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthViewModel extends Bloc<AuthEvent, AuthState> {
  AuthViewModel(this._authRepository) : super(const AuthState()) {
    on<AuthStreamInitialized>(_onStreamInitialized);
    on<AuthRegistered>(_onRegistered);
    on<AuthSignedIn>(_onSignedIn);
    on<AuthSignedOut>(_onSignedOut);
  }

  final AuthRepositoryInterface _authRepository;

  Future<void> _onStreamInitialized(
    AuthStreamInitialized event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach(
      _authRepository.authStateChanges,
      onData: (user) {
        return state.copyWith(
          isAuthenticated: user != null,
          status: ViewModelStatus.success,
        );
      },
    );
  }

  Future<void> _onRegistered(
    AuthRegistered event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      await _authRepository.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(status: ViewModelStatus.success));
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onSignedIn(
    AuthSignedIn event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      await _authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(status: ViewModelStatus.success));
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onSignedOut(
    AuthSignedOut event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      await _authRepository.signOut();

      emit(state.copyWith(status: ViewModelStatus.success));
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }
}
