import 'package:equatable/equatable.dart';

class UserOutput extends Equatable {
  const UserOutput({
    required this.id,
    required this.name,
    required this.hasSetInitialPreferences,
  });

  static const UserOutput empty = UserOutput(
    id: '',
    name: '',
    hasSetInitialPreferences: false,
  );

  factory UserOutput.fromJson(Map<String, dynamic> json) {
    return empty.copyWith(
      id: json['userId'],
      name: json['name'],
      hasSetInitialPreferences: json['hasSeenInitialPreferencesModal'],
    );
  }

  final String id;
  final String name;
  final bool hasSetInitialPreferences;

  UserOutput copyWith({
    String? id,
    String? name,
    bool? hasSetInitialPreferences,
  }) {
    return UserOutput(
      id: id ?? this.id,
      name: name ?? this.name,
      hasSetInitialPreferences:
          hasSetInitialPreferences ?? this.hasSetInitialPreferences,
    );
  }

  bool get isEmpty => this == UserOutput.empty;
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [
        id,
        name,
        hasSetInitialPreferences,
      ];
}
