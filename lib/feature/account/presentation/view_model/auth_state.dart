part of 'auth_view_model.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = ViewModelStatus.initial,
    this.isAuthenticated = false,
    this.isRegistered = false,
    this.error,
  });

  final ViewModelStatus status;

  /// To check if the user is authenticated with Firebase
  final bool isAuthenticated;

  /// To check if the user has a registered user profile
  final bool isRegistered;
  final Exception? error;

  AuthState copyWith({
    ViewModelStatus? status,
    bool? isAuthenticated,
    bool? isRegistered,
    Exception? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      isRegistered: isRegistered ?? this.isRegistered,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
    );
  }

  bool get isFetchingAuthStatus => status.isInitial || status.isLoading;

  bool get isAuthorized => isAuthenticated && isRegistered;

  @override
  List<Object?> get props => [
        status,
        isAuthenticated,
        isRegistered,
        error,
      ];
}
