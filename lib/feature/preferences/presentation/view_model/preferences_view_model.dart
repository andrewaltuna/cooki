import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/medication.dart';
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
    on<PreferencesPromoNotificationsToggled>(_onPromoNotificationsToggled);
    on<PreferencesMedicationAdded>(_onMedicationAdded);
    on<PreferencesMedicationRemoved>(_onMedicationRemoved);
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
          promoNotifications: result.promoNotifications,
          medications: result.medications,
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

  void _onMedicationAdded(
    PreferencesMedicationAdded event,
    Emitter<PreferencesState> emit,
  ) {
    final updatedMedications = [
      ...state.medications,
      event.medication,
    ];

    emit(state.copyWith(medications: updatedMedications));
  }

  void _onMedicationRemoved(
    PreferencesMedicationRemoved event,
    Emitter<PreferencesState> emit,
  ) {
    final updatedMedications = [...state.medications];

    updatedMedications.removeAt(event.index);

    emit(state.copyWith(medications: updatedMedications));
  }

  void _onPromoNotificationsToggled(
    PreferencesPromoNotificationsToggled event,
    Emitter<PreferencesState> emit,
  ) {
    emit(state.copyWith(promoNotifications: !state.promoNotifications));
  }

  Future<void> _onSaved(
    PreferencesSaved event,
    Emitter<PreferencesState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(submissionStatus: ViewModelStatus.loading));

      final input = UpdatePreferencesInput(
        productCategories: Set.from(state.productCategories),
        dietaryRestrictions: Set.from(state.dietaryRestrictions),
        medications: Set.from(state.medications),
        promoNotifications: state.promoNotifications,
      );

      await _repository.updatePreferences(input);

      emit(state.copyWith(submissionStatus: ViewModelStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(submissionStatus: ViewModelStatus.error));
    }
  }
}
