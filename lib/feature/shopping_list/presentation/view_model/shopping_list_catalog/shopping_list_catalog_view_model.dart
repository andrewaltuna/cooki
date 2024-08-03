import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/shopping_list/data/model/chat_shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_gemini_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
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
    on<ShoppingListByGeminiCreated>(_onGeminiCreated);
    on<ShoppingListCreated>(_onCreated);
    on<ShoppingListEntryUpdated>(_onUpdated);
    on<ShoppingListEntryDeleted>(_onDeleted);
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

  Future<void> _onGeminiCreated(
    ShoppingListByGeminiCreated event,
    Emitter<ShoppingListCatalogState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await _repository.createGeminiShoppingList(
        CreateGeminiShoppingListInput(
          name: event.name,
          items: event.items,
        ),
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

  Future<void> _onCreated(
    ShoppingListCreated event,
    Emitter<ShoppingListCatalogState> emit,
  ) async {
    try {
      emit(
        state.copyWith(status: ViewModelStatus.loading),
      );

      final result = await _repository.createShoppingList(
        CreateShoppingListInput(
          name: event.name,
          budget: event.budget,
        ),
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

  void _onUpdated(
    ShoppingListEntryUpdated event,
    Emitter<ShoppingListCatalogState> emit,
  ) {
    try {
      emit(
        state.copyWith(
          status: ViewModelStatus.loading,
        ),
      );

      final shoppingLists = state.shoppingLists
          .map(
            (list) => list.id == event.updatedShoppingList.id
                ? event.updatedShoppingList
                : list,
          )
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

  Future<void> _onDeleted(
    ShoppingListEntryDeleted event,
    Emitter<ShoppingListCatalogState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: ViewModelStatus.loading,
        ),
      );

      final shoppingLists = state.shoppingLists
          .where((list) => list.id != event.shoppingListId)
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
}
