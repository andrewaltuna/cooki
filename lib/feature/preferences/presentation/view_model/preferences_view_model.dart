import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/preferences/data/model/input/update_preferences_input.dart';
import 'package:cooki/feature/preferences/data/repository/preferences_repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesViewModel extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesViewModel(this._repository) : super(const PreferencesState()) {
    on<PreferencesRequested>(_onRequested);
    on<PreferencesProductCategorySelected>(_onProductCategorySelected);
    on<PreferencesDietaryRestrictionSelected>(_onDietaryRestrictionSelected);
    on<PreferencesSaved>(_onSaved);
  }

  final PreferencesRepositoryInterface _repository;

  Future<void> _onRequested(
    PreferencesRequested event,
    Emitter<PreferencesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await _repository.getPreferences();

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          productCategories: result.productCategories,
          dietaryRestrictions: result.dietaryRestrictions,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

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

      final input = UpdatePreferencesInput(
        productCategories: state.productCategories,
        dietaryRestrictions: state.dietaryRestrictions,
      );

      await _repository.updatePreferences(input);

      emit(state.copyWith(status: ViewModelStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(status: ViewModelStatus.error));
    }
  }
}
