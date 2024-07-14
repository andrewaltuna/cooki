part of 'auth_view_model.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStreamInitialized extends AuthEvent {
  const AuthStreamInitialized();
}

class AuthStatusUpdated extends AuthEvent {
  const AuthStatusUpdated(this.firebaseUser);

  final User? firebaseUser;

  @override
  List<Object?> get props => [firebaseUser];
}

class AuthSignedIn extends AuthEvent {
  const AuthSignedIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthUserCreated extends AuthEvent {
  const AuthUserCreated({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthRegistrationStatusUpdated extends AuthEvent {
  const AuthRegistrationStatusUpdated();
}

class AuthSignedOut extends AuthEvent {
  const AuthSignedOut();
}
