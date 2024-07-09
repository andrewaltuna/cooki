import 'package:equatable/equatable.dart';

class EditUserProfileInput extends Equatable {
  const EditUserProfileInput({
    this.hasSeenInitialPreferencesModal,
  });

  final bool? hasSeenInitialPreferencesModal;

  Map<String, dynamic> toJson() {
    return {
      'hasSeenInitialPreferencesModal': hasSeenInitialPreferencesModal,
    };
  }

  @override
  List<Object?> get props => [
        hasSeenInitialPreferencesModal,
      ];
}
