import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_form_errors_state.dart';

class LoginFormErrorsViewModel extends Cubit<LoginFormErrorsState> {
  LoginFormErrorsViewModel() : super(const LoginFormErrorsState());

  void emailError(String? emailError) {
    emit(state.copyWith(emailError: () => emailError));
  }

  void passwordError(String? passwordError) {
    emit(state.copyWith(passwordError: () => passwordError));
  }
}
