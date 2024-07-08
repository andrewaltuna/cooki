import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/account/data/model/user_output.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/preferences/data/model/input/edit_user_profile_input.dart';
import 'package:cooki/feature/preferences/data/repository/preferences_repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesViewModel extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesViewModel(this._repository) : super(const PreferencesState()) {
    on<PreferencesInitalized>(_onInitialized);
    on<PreferencesProductCategorySelected>(_onProductCategorySelected);
    on<PreferencesDietaryRestrictionSelected>(_onDietaryRestrictionSelected);
    on<PreferencesSaved>(_onSaved);
  }

  final PreferencesRepositoryInterface _repository;

  // TODO implement
  void _onInitialized(
    PreferencesInitalized event,
    Emitter<PreferencesState> emit,
  ) {}

  void _onProductCategorySelected(
    PreferencesProductCategorySelected event,
    Emitter<PreferencesState> emit,
  ) {
    final updatedCategories = [...state.productCategories];

    if (updatedCategories.contains(event.category)) {
      updatedCategories.remove(event.category);
    } else {
      updatedCategories.add(event.category);
    }

    emit(state.copyWith(productCategories: updatedCategories));
  }

  void _onDietaryRestrictionSelected(
    PreferencesDietaryRestrictionSelected event,
    Emitter<PreferencesState> emit,
  ) {
    final updatedRestrictions = [...state.dietaryRestrictions];

    if (updatedRestrictions.contains(event.restriction)) {
      updatedRestrictions.remove(event.restriction);
    } else {
      updatedRestrictions.add(event.restriction);
    }

    emit(state.copyWith(dietaryRestrictions: updatedRestrictions));
  }

  Future<void> _onSaved(
    PreferencesSaved event,
    Emitter<PreferencesState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      final input = EditUserProfileInput(
        productCategories: event.isSkip ? null : state.productCategories,
        dietaryRestrictions: event.isSkip ? null : state.dietaryRestrictions,
        hasSeenInitialPreferencesModal: event.hasSeenInitalPreferencesModal,
      );

      await _repository.updateUserProfile(input);

      emit(state.copyWith(status: ViewModelStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(status: ViewModelStatus.error));
    }
  }
}
