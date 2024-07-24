import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/account/data/model/input/edit_user_profile_input.dart';
import 'package:cooki/feature/account/data/model/output/user_output.dart';
import 'package:cooki/feature/account/data/repository/account_repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountViewModel extends Bloc<AccountEvent, AccountState> {
  AccountViewModel(this._accountRepository) : super(const AccountState()) {
    on<AccountRequested>(_onRequested);
    on<AccountRegistered>(_onRegistered);
    on<AccountInitialPrefsSet>(_onInitialPrefsSet);
    on<AccountCleared>(_onCleared);
  }

  final AccountRepositoryInterface _accountRepository;

  Future<void> _onRequested(
    AccountRequested event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final user = await _accountRepository.getUserProfile();

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          user: user,
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
    AccountRegistered event,
    Emitter<AccountState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      final user = await _accountRepository.createUserProfile(event.name);

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          user: user,
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

  void _onInitialPrefsSet(
    AccountInitialPrefsSet event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final updatedUser = await _accountRepository.editUserProfile(
        const EditUserProfileInput(
          hasSeenInitialPreferencesModal: true,
        ),
      );

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          user: updatedUser,
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

  void _onCleared(
    AccountCleared _,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountState());
  }
}
