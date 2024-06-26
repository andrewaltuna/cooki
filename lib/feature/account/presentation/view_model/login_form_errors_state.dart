part of 'login_form_errors_view_model.dart';

class LoginFormErrorsState extends Equatable {
  const LoginFormErrorsState({
    this.emailError,
    this.passwordError,
  });

  final String? emailError;
  final String? passwordError;

  LoginFormErrorsState copyWith({
    ValueGetter<String?>? emailError,
    ValueGetter<String?>? passwordError,
  }) {
    return LoginFormErrorsState(
      emailError: emailError != null ? emailError() : this.emailError,
      passwordError:
          passwordError != null ? passwordError() : this.passwordError,
    );
  }

  bool get hasErrors => emailError != null || passwordError != null;

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
      ];
}
