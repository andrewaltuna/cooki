part of 'account_view_model.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class AccountRequested extends AccountEvent {
  const AccountRequested();
}

class AccountRegistered extends AccountEvent {
  const AccountRegistered(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class AccountInitialPrefsSet extends AccountEvent {
  const AccountInitialPrefsSet();
}

class AccountCleared extends AccountEvent {
  const AccountCleared();
}
