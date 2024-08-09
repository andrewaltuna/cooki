import 'dart:async';

import 'package:cooki/feature/account/data/repository/account_repository_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/account/data/repository/auth_repository_interface.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthViewModel extends Bloc<AuthEvent, AuthState> {
  AuthViewModel(
    this._authRepository,
    this._accountRepository,
  ) : super(const AuthState()) {
    on<AuthStreamInitialized>(_onStreamInitialized);
    on<AuthStatusUpdated>(_onStatusUpdated);
    on<AuthUserCreated>(_onUserCreated);
    on<AuthRegistrationStatusUpdated>(_onRegistrationStatusUpdated);
    on<AuthSignedIn>(_onSignedIn);
    on<AuthSignedOut>(_onSignedOut);
  }

  final AuthRepositoryInterface _authRepository;
  final AccountRepositoryInterface _accountRepository;

  Future<void> _onStreamInitialized(
    AuthStreamInitialized event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.reloadUser();

    _authRepository.authStateChanges.listen(
      (user) => add(AuthStatusUpdated(user)),
    );
  }

  Future<void> _onStatusUpdated(
    AuthStatusUpdated event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      // Reload user to ensure token is not expired
      await _authRepository.reloadUser();

      final isAuthenticated = event.firebaseUser != null;

      if (isAuthenticated) {
        final user = await _accountRepository.getUserProfile();

        emit(
          state.copyWith(
            isAuthenticated: isAuthenticated,
            isRegistered: user != null,
            status: ViewModelStatus.success,
          ),
        );

        return;
      }

      emit(
        state.copyWith(
          isAuthenticated: false,
          isRegistered: false,
          status: ViewModelStatus.success,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onUserCreated(
    AuthUserCreated event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      // Register Firebase user
      await _authRepository.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  void _onRegistrationStatusUpdated(
    AuthRegistrationStatusUpdated _,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        isRegistered: true,
      ),
    );
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
