part of 'auth_view_model.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = ViewModelStatus.initial,
    this.user = UserOutput.empty,
    this.isFireAuth = false,
    this.error,
  });

  final ViewModelStatus status;
  final UserOutput user;

  /// To check if the user is authenticated with Firebase
  final bool isFireAuth;
  final Exception? error;

  AuthState copyWith({
    ViewModelStatus? status,
    UserOutput? user,
    bool? isFireAuth,
    Exception? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      isFireAuth: isFireAuth ?? this.isFireAuth,
      error: error,
    );
  }

  bool get isRegistered => user.isNotEmpty;

  @override
  List<Object?> get props => [
        status,
        user,
        isFireAuth,
        error,
      ];
}
