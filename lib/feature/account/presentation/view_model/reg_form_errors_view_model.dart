import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reg_form_errors_state.dart';

class RegFormErrorsViewModel extends Cubit<RegFormErrorsState> {
  RegFormErrorsViewModel() : super(const RegFormErrorsState());

  void emailError(String? error) {
    emit(state.copyWith(emailError: () => error));
  }

  void passwordError(String? error) {
    emit(state.copyWith(passwordError: () => error));
  }

  void confirmPasswordError(String? error) {
    emit(state.copyWith(confirmPassError: () => error));
  }
}
