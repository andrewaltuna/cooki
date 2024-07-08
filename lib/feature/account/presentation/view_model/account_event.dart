part of 'account_view_model.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class AccountInitialized extends AccountEvent {
  const AccountInitialized(this.user);

  final UserOutput user;

  @override
  List<Object> get props => [user];
}

class AccountInitialPrefsSet extends AccountEvent {
  const AccountInitialPrefsSet();
}
