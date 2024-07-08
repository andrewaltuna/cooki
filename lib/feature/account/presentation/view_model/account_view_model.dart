import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/account/data/model/user_output.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountViewModel extends Bloc<AccountEvent, AccountState> {
  AccountViewModel() : super(const AccountState()) {
    on<AccountInitialized>(_onAccountInitialized);
    on<AccountInitialPrefsSet>(_onInitialPrefsSet);
  }

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
  ) {
    // TODO api call

    final updatedUser = state.user.copyWith(hasSetInitialPreferences: true);

    emit(state.copyWith(user: updatedUser));
  }
}
