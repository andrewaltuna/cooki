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

class AuthRegistered extends AuthEvent {
  const AuthRegistered({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthUserProfileCreated extends AuthEvent {
  const AuthUserProfileCreated(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class AuthSignedOut extends AuthEvent {
  const AuthSignedOut();
}
