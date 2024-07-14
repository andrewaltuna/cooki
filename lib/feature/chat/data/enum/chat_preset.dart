import 'package:cooki/common/component/app_icons.dart';
import 'package:flutter_svg/svg.dart';

enum ChatPreset {
  specialOffers(
    displayLabel: 'Special Offers',
    description: 'Discover our latest products and offers!',
    textPreset: 'What are your latest products and promotions?',
  ),
  activity(
    displayLabel: 'Activity',
    description: "Tell me what you're doing and I'll find what you need!",
    textPreset:
        "I'm planning to go$selectionTarget\nCan you help me find what I need?",
  ),
  recipeGenerator(
    displayLabel: 'Recipe Generator',
    description:
        "Whip up a new recipe and I'll get the ingredients for it too!",
    textPreset:
        'Give me the recipe for$selectionTarget\nList down the ingredients I need to make it.',
  ),
  ecoWarrior(
    displayLabel: 'Eco-Warrior',
    description:
        "I'll help you find our green and sustainably sourced products.",
    textPreset: 'Can you help me find green and sustainably sourced products?',
  );

  const ChatPreset({
    required this.displayLabel,
    required this.description,
    required this.textPreset,
  });

  static const selectionTarget = ':  ';

  final String displayLabel;
  final String description;
  final String textPreset;

  bool get isSpecialOffers => this == specialOffers;
  bool get isActivity => this == activity;
  bool get isRecipeGenerator => this == recipeGenerator;
  bool get isEcoWarrior => this == ecoWarrior;

  SvgPicture get icon {
    return switch (this) {
      ChatPreset.specialOffers => AppIcons.specialOffers,
      ChatPreset.activity => AppIcons.activity,
      ChatPreset.recipeGenerator => AppIcons.recipeGenerator,
      ChatPreset.ecoWarrior => AppIcons.ecoWarrior,
    };
  }
}
