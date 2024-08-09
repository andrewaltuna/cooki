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
    on<ShoppingListItemSwitched>(_onItemSwitched);
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

      emit(
        state.copyWith(
          updateStatus: ViewModelStatus.success,
          shoppingList: state.shoppingList.copyWith(
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
          updateItemStatus: ViewModelStatus.loading,
        ),
      );

      final response = await _repository.createShoppingListItem(
        CreateShoppingListItemInput(
          shoppingListId: event.shoppingListId,
          productId: event.formOutput.productId,
          quantity: event.formOutput.quantity,
        ),
      );
      final shoppingList = state.shoppingList;

      emit(
        state.copyWith(
          updateItemStatus: ViewModelStatus.success,
          shoppingList: shoppingList.copyWith(
            items: [...shoppingList.items, response],
          ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          updateItemStatus: ViewModelStatus.error,
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
          updateItemStatus: ViewModelStatus.loading,
        ),
      );

      final response = await _repository.updateShoppingListItem(
        UpdateShoppingListItemInput(
          id: event.itemId,
          productId: event.formOutput.productId,
          quantity: event.formOutput.quantity,
        ),
      );

      final shoppingList = state.shoppingList;

      emit(
        state.copyWith(
          updateItemStatus: ViewModelStatus.success,
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
          updateItemStatus: ViewModelStatus.error,
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
          updateItemStatus: ViewModelStatus.loading,
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
          updateItemStatus: ViewModelStatus.success,
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
          updateItemStatus: ViewModelStatus.error,
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
          deleteItemStatus: ViewModelStatus.loading,
        ),
      );

      await _repository.deleteShoppingListItem(
        event.id,
      );

      final items = [...state.shoppingList.items]..removeWhere(
          (item) => item.id == event.id,
        );

      emit(
        state.copyWith(
          deleteItemStatus: ViewModelStatus.success,
          shoppingList: state.shoppingList.copyWith(
            items: items,
          ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          deleteItemStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onItemSwitched(
    ShoppingListItemSwitched event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          switchItemStatus: ViewModelStatus.loading,
        ),
      );

      final response = await _repository.updateShoppingListItem(
        UpdateShoppingListItemInput(
          id: event.itemId,
          productId: event.productId,
        ),
      );
      final shoppingList = state.shoppingList;

      emit(
        state.copyWith(
          switchItemStatus: ViewModelStatus.success,
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
          switchItemStatus: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }
}
