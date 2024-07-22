import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListViewModel extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListViewModel(this._repository) : super(const ShoppingListState()) {
    on<ShoppingListsRequested>(_onRequested);
    on<ShoppingListRequested>(_onSelected);
    on<ShoppingListCreated>(_onCreated);
    on<ShoppingListDeleted>(_onDeleted);
    // Item events
    on<ShoppingListItemCreated>(_onItemCreated);
    on<ShoppingListItemUpdated>(_onItemUpdated);
    on<ShoppingListItemDeleted>(_onItemDeleted);
  }

  final ShoppingListRepositoryInterface _repository;

  Future<void> _onRequested(
    ShoppingListsRequested event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final result = await _repository.getShoppingLists();

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          shoppingLists: result,
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

  Future<void> _onSelected(
      ShoppingListRequested event, Emitter<ShoppingListState> emit) async {
    try {
      emit(
        state.copyWith(
          status: ViewModelStatus.loading,
        ),
      );

      final result = await _repository.getShoppingList(event.id);

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          selectedShoppingList: result,
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

  Future<void> _onCreated(
      ShoppingListCreated event, Emitter<ShoppingListState> emit) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final input = CreateShoppingListInput(
        name: event.name,
        budget: double.parse(event.budget),
      );

      final result = await _repository.createShoppingList(
        input,
      );

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          shoppingLists: [...state.shoppingLists, result],
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

  Future<void> _onDeleted(
    ShoppingListDeleted event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final result = await _repository.deleteShoppingList(event.id);

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          shoppingLists: state.shoppingLists
              .where((list) => list.id != result.id)
              .toList(),
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

  // Shopping list item events
  Future<void> _onItemCreated(
      ShoppingListItemCreated event, Emitter<ShoppingListState> emit) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final result = await _repository.createShoppingListItem(event.input);

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          // TODO: Deal with possible undefined selectedShoppingList
          selectedShoppingList: state.selectedShoppingList?.copyWith(
            items: [...state.selectedShoppingList!.items, result],
          ),
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

  Future<void> _onItemUpdated(
    ShoppingListItemUpdated event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: ViewModelStatus.loading,
        ),
      );

      final result = await _repository.updateShoppingListItem(event.input);

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          // TODO: Deal with possible undefined selectedShoppingList
          selectedShoppingList: state.selectedShoppingList?.copyWith(
            items: state.selectedShoppingList?.items
                .map((item) => item.id == result.id ? result : item)
                .toList(),
          ),
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

  Future<void> _onItemDeleted(
    ShoppingListItemDeleted event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final result = await _repository.deleteShoppingList(event.id);

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          // TODO: Deal with possible undefined selectedShoppingList
          selectedShoppingList: state.selectedShoppingList?.copyWith(
            items: state.selectedShoppingList?.items
                .where((item) => item.id != result.id)
                .toList(),
          ),
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
