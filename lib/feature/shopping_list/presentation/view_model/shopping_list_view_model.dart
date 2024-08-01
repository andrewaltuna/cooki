import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item_form_output.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_list_state.dart';
part 'shopping_list_event.dart';

class ShoppingListViewModel extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListViewModel(this._repository) : super(const ShoppingListState()) {
    on<ShoppingListRequested>(_onInitialized);
    on<ShoppingListUpdated>(_onUpdated);
    on<ShoppingListDeleted>(_onDeleted);
    on<ShoppingListItemCreated>(_onItemCreated);
    on<ShoppingListItemUpdated>(_onItemUpdated);
    on<ShoppingListItemToggled>(_onItemToggled);
    on<ShoppingListItemDeleted>(_onItemDeleted);
  }

  final ShoppingListRepositoryInterface _repository;

  void _onInitialized(
    ShoppingListRequested event,
    Emitter<ShoppingListState> emit,
  ) {
    emit(
      state.copyWith(
        status: ViewModelStatus.success,
        shoppingList: event.shoppingList,
      ),
    );
  }

  Future<void> _onUpdated(
    ShoppingListUpdated event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          updateStatus: ViewModelStatus.loading,
        ),
      );

      final result = await _repository.updateShoppingList(
        UpdateShoppingListInput(
          id: state.shoppingList.id,
          name: event.name,
          budget: event.budget,
        ),
      );

      final shoppingList = state.shoppingList;

      emit(
        state.copyWith(
          updateStatus: ViewModelStatus.success,
          shoppingList: shoppingList.copyWith(
            name: result.name,
            budget: result.budget,
          ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          updateStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onDeleted(
    ShoppingListDeleted event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          deleteStatus: ViewModelStatus.loading,
        ),
      );

      await _repository.deleteShoppingList(event.id);

      emit(
        state.copyWith(
          deleteStatus: ViewModelStatus.success,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          deleteStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onItemCreated(
    ShoppingListItemCreated event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.loading,
        ),
      );

      final response = await _repository.createShoppingListItem(
        CreateShoppingListItemInput(
          shoppingListId: event.shoppingListId,
          label: event.formOutput.label,
          productId: event.formOutput.productId,
          quantity: event.formOutput.quantity,
        ),
      );
      final shoppingList = state.shoppingList;

      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.success,
          shoppingList: shoppingList.copyWith(
            items: [...shoppingList.items, response],
          ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onItemUpdated(
    ShoppingListItemUpdated event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.loading,
        ),
      );

      final response = await _repository.updateShoppingListItem(
        UpdateShoppingListItemInput(
          id: event.itemId,
          label: event.formOutput.label,
          productId: event.formOutput.productId,
          quantity: event.formOutput.quantity,
        ),
      );

      final shoppingList = state.shoppingList;

      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.success,
          shoppingList: shoppingList.copyWith(
            items: shoppingList.items
                .map((item) => item.id == response.id ? response : item)
                .toList(),
          ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onItemToggled(
    ShoppingListItemToggled event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.loading,
        ),
      );

      final response = await _repository.updateShoppingListItem(
        UpdateShoppingListItemInput(
          id: event.itemId,
          isChecked: event.checked,
        ),
      );
      final shoppingList = state.shoppingList;

      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.success,
          shoppingList: shoppingList.copyWith(
            items: shoppingList.items
                .map((item) => item.id == response.id ? response : item)
                .toList(),
          ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onItemDeleted(
    ShoppingListItemDeleted event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.loading,
        ),
      );

      final response = await _repository.deleteShoppingListItem(
        event.id,
      );

      final shoppingList = state.shoppingList;

      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.success,
          shoppingList: shoppingList.copyWith(
            items: shoppingList.items
                .where((item) => item.id != response.id)
                .toList(),
          ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          itemStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }
}
