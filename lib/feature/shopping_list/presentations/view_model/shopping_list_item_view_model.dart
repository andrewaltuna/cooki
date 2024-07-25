import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_list_item_state.dart';
part 'shopping_list_item_event.dart';

class ShoppingListItemViewModel
    extends Bloc<ShoppingListItemEvent, ShoppingListItemState> {
  ShoppingListItemViewModel(this._repository)
      : super(const ShoppingListItemState()) {
    on<ShoppingListItemRequested>(_onItemRequested);
    on<ShoppingListItemCreated>(_onItemCreated);
    on<ShoppingListItemUpdated>(_onItemUpdated);
    on<ShoppingListItemDeleted>(_onItemDeleted);
  }

  // Shares same repository as ShoppingListViewModel
  final ShoppingListRepositoryInterface _repository;

  Future<void> _onItemRequested(ShoppingListItemRequested event,
      Emitter<ShoppingListItemState> emit) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final result = await _repository.getShoppingListItem(
        event.shoppingListItemId,
      );

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          item: result,
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

  Future<void> _onItemCreated(
    ShoppingListItemCreated event,
    Emitter<ShoppingListItemState> emit,
  ) async {
    try {
      emit(
        state.copyWith(submissionStatus: ViewModelStatus.loading),
      );

      await _repository.createShoppingListItem(
        event.input,
      );

      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.success,
          item: null,
        ),
      );
    } on Exception catch (error) {
      print("Error: $error");
      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onItemUpdated(
    ShoppingListItemUpdated event,
    Emitter<ShoppingListItemState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.loading,
        ),
      );

      await _repository.updateShoppingListItem(event.input);

      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.success,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onItemDeleted(
    ShoppingListItemDeleted event,
    Emitter<ShoppingListItemState> emit,
  ) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      await _repository.deleteShoppingListItem(
        event.input,
      );

      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.success,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }
}
