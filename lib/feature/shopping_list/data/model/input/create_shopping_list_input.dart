import 'package:equatable/equatable.dart';

class CreateShoppingListInput extends Equatable {
  const CreateShoppingListInput({
    required this.name,
    required this.budget,
  });

  final String name;
  final double budget;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'budget': budget,
    };
  }

  @override
  List<Object?> get props => [
        name,
        budget,
      ];
}
