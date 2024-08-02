import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/medication.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'interfered_restrictions_event.dart';
part 'interfered_restrictions_state.dart';

class InterferedRestrictionsViewModel
    extends Bloc<InterferedRestrictionsEvent, InterferedRestrictionsState> {
  InterferedRestrictionsViewModel(this._repository)
      : super(const InterferedRestrictionsState()) {
    on<InterferedRestrictionsRequested>(_onRequested);
  }

  final ShoppingListRepositoryInterface _repository;

  Future<void> _onRequested(
    InterferedRestrictionsRequested event,
    Emitter<InterferedRestrictionsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await _repository.getInterferedRestrictions(
        event.productId,
      );

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          productId: event.productId,
          dietaryRestrictions: result.dietaryRestrictions,
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
}
