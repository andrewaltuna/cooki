import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListViewModel extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListViewModel(this._repository) : super(const ShoppingListState()) {
    on<ShoppingListsRequested>(_onRequested);
    on<ShoppingListCreated>(_onCreated);
  }

  final ShoppingListRepositoryInterface _repository;

  Future<void> _onRequested(
    ShoppingListsRequested event,
    Emitter<ShoppingListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await _repository.getShoppingLists();
      emit(state.copyWith(
          status: ViewModelStatus.success, shoppingLists: result));
    } on Exception catch (error) {
      emit(state.copyWith(status: ViewModelStatus.error, error: error));
    }
  }

  Future<void> _onCreated(
      ShoppingListCreated event, Emitter<ShoppingListState> emit) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      // TODO: Pass in data
      final result = await _repository.createShoppingList(
          event.name, double.parse(event.budget));
      emit(state.copyWith(
          status: ViewModelStatus.success,
          shoppingLists: [...state.shoppingLists, result]));
    } on Exception catch (error) {
      emit(state.copyWith(status: ViewModelStatus.error, error: error));
    }
  }
}
