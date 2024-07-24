part of 'account_view_model.dart';

class AccountState extends Equatable {
  const AccountState({
    this.status = ViewModelStatus.initial,
    this.user = UserOutput.empty,
    this.error,
  });

  final ViewModelStatus status;
  final UserOutput user;
  final Exception? error;

  AccountState copyWith({
    ViewModelStatus? status,
    UserOutput? user,
    Exception? error,
  }) {
    return AccountState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      (status.isInitial || status.isLoading) && user.isEmpty;

  bool get shouldShowInitialPrefsModal =>
      user.isNotEmpty && !user.hasSetInitialPreferences;

  @override
  List<Object?> get props => [
        status,
        user,
        error,
      ];
}
