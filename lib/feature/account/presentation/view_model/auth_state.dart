part of 'auth_view_model.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = ViewModelStatus.initial,
    this.isAuthenticated = false,
    this.error,
  });

  final ViewModelStatus status;
  final bool isAuthenticated;
  final Exception? error;

  AuthState copyWith({
    ViewModelStatus? status,
    bool? isAuthenticated,
    Exception? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isAuthenticated,
        error,
      ];
}
