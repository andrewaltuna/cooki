import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'shopping_list_catalog_event.dart';
part 'shopping_list_catalog_state.dart';

class ShoppingListCatalogViewModel
    extends Bloc<ShoppingListCatalogEvent, ShoppingListCatalogState> {
  ShoppingListCatalogViewModel(this._repository)
      : super(const ShoppingListCatalogState()) {
    on<ShoppingListCatalogRequested>(_onRequested);
    on<ShoppingListCreated>(_onCreated);
    on<ShoppingListEntryUpdated>(_onUpdated);
    // TODO: Delete
    on<ShoppingListSelected>(_onSelected);
    on<ShoppingListDeleted>(_onDeleted);
    on<ShoppingListItemToggled>(_onItemToggle);
  }

  final ShoppingListRepositoryInterface _repository;

  Future<void> _onRequested(
    ShoppingListCatalogRequested event,
    Emitter<ShoppingListCatalogState> emit,
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

  void _onUpdated(
    ShoppingListEntryUpdated event,
    Emitter<ShoppingListCatalogState> emit,
  ) {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final shoppingLists = state.shoppingLists
          .map((list) => list.id == event.updatedShoppingList.id
              ? event.updatedShoppingList
              : list)
          .toList();

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          shoppingLists: shoppingLists,
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
      ShoppingListCreated event, Emitter<ShoppingListCatalogState> emit) async {
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

  Future<void> _onSelected(
    ShoppingListSelected event,
    Emitter<ShoppingListCatalogState> emit,
  ) async {
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

  Future<void> _onDeleted(
    ShoppingListDeleted event,
    Emitter<ShoppingListCatalogState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.loading,
        ),
      );

      final result = await _repository.deleteShoppingList(event.id);

      emit(
        state.copyWith(
          submissionStatus: ViewModelStatus.success,
          shoppingLists: state.shoppingLists
              .where((list) => list.id != result.id)
              .toList(),
          selectedShoppingList: null,
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

  Future<void> _onItemToggle(
    ShoppingListItemToggled event,
    Emitter<ShoppingListCatalogState> emit,
  ) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final result = await _repository.updateShoppingListItem(event.input);

      final shoppingList = state.selectedShoppingList!;
      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          selectedShoppingList: shoppingList.copyWith(
            items: shoppingList.items
                .map((list) => list.id == result.id ? result : list)
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
