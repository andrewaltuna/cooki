import 'dart:async';

import 'package:cooki/feature/account/data/model/output/user_output.dart';
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
    on<AuthRegistered>(_onRegistered);
    on<AuthUserProfileCreated>(_onUserProfileCreated);
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
      // Reload user to ensure token is not expired
      await _authRepository.reloadUser();

      final isAuth = event.firebaseUser != null;

      if (isAuth) {
        final userOutput = await _accountRepository.getUserProfile();

        emit(
          state.copyWith(
            isFireAuth: isAuth,
            user: userOutput,
            status: ViewModelStatus.success,
          ),
        );

        return;
      }

      emit(
        state.copyWith(
          isFireAuth: isAuth,
          user: UserOutput.empty,
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

  Future<void> _onRegistered(
    AuthRegistered event,
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

  Future<void> _onUserProfileCreated(
    AuthUserProfileCreated event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      final userOutput = await _accountRepository.createUserProfile(event.name);

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          user: userOutput,
        ),
      );
    } on Exception catch (error) {
      print(error);
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
