part of 'reg_form_errors_view_model.dart';

class RegFormErrorsState extends Equatable {
  const RegFormErrorsState({
    this.emailError,
    this.passwordError,
    this.confirmPassError,
  });

  final String? emailError;
  final String? passwordError;
  final String? confirmPassError;

  RegFormErrorsState copyWith({
    ValueGetter<String?>? emailError,
    ValueGetter<String?>? passwordError,
    ValueGetter<String?>? confirmPassError,
  }) {
    return RegFormErrorsState(
      emailError: emailError != null ? emailError() : this.emailError,
      passwordError:
          passwordError != null ? passwordError() : this.passwordError,
      confirmPassError:
          confirmPassError != null ? confirmPassError() : this.confirmPassError,
    );
  }

  bool get hasErrors =>
      emailError != null || passwordError != null || confirmPassError != null;

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
        confirmPassError,
      ];
}
