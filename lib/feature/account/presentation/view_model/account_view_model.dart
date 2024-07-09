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
    on<AccountInitialized>(_onAccountInitialized);
    on<AccountInitialPrefsSet>(_onInitialPrefsSet);
  }

  final AccountRepositoryInterface _accountRepository;

  void _onAccountInitialized(
    AccountInitialized event,
    Emitter<AccountState> emit,
  ) {
    print('ACCOUNT INITIALIZED');
    emit(
      state.copyWith(
        status: ViewModelStatus.success,
        user: event.user,
      ),
    );
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
}
