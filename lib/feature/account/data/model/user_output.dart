import 'package:equatable/equatable.dart';

class UserOutput extends Equatable {
  const UserOutput({
    required this.name,
    required this.hasSetInitialPreferences,
  });

  static const UserOutput empty = UserOutput(
    name: '',
    hasSetInitialPreferences: false,
  );

  factory UserOutput.fromJson(Map<String, dynamic> json) {
    return empty.copyWith(
      name: json['name'],
      // TODO transfer to preferences output
      // dietaryRestrictions: preferences['dietary_restrictions']
      //     .map(
      //       (restriction) => DietaryRestriction.values.firstWhere(
      //         (element) => element.apiValue == restriction,
      //         orElse: () => DietaryRestriction.values.first,
      //       ),
      //     )
      //     .toList(),
      // productCategories: preferences['general']
      //     .map(
      //       (restriction) => ProductCategory.values.firstWhere(
      //         (element) => element.apiValue == restriction,
      //         orElse: () => ProductCategory.values.first,
      //       ),
      //     )
      //     .toList(),
      hasSetInitialPreferences: json['hasSeenInitialPreferencesModal'],
    );
  }

  final String name;
  final bool hasSetInitialPreferences;

  UserOutput copyWith({
    String? name,
    bool? hasSetInitialPreferences,
  }) {
    return UserOutput(
      name: name ?? this.name,
      hasSetInitialPreferences:
          hasSetInitialPreferences ?? this.hasSetInitialPreferences,
    );
  }

  bool get isEmpty => this == UserOutput.empty;
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [
        name,
        hasSetInitialPreferences,
      ];
}
