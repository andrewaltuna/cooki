import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item_form_output.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_list_item_form_event.dart';
part 'shopping_list_item_form_state.dart';

class ShoppingListItemFormViewModel
    extends Bloc<ShoppingListItemFormEvent, ShoppingListItemFormState> {
  ShoppingListItemFormViewModel() : super(const ShoppingListItemFormState()) {
    on<ItemFormInitialized>(_onInitialized);
    on<ItemFormSectionSelected>(_onSectionSelected);
    on<ItemFormProductSelected>(_onProductSelected);
    on<ItemFormQuantityChanged>(_onQuantityChanged);
    on<ItemFormProductIdErrorChanged>(_onProductIdErrorChanged);
  }

  void _onInitialized(
    ItemFormInitialized event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        status: ViewModelStatus.success,
        section: event.section,
        productId: event.productId,
        quantity: event.quantity,
      ),
    );
  }

  void _onSectionSelected(
    ItemFormSectionSelected event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    if (event.section == state.section) return;

    emit(
      state.copyWith(
        section: event.section,
        productId: '',
      ),
    );
  }

  void _onProductSelected(
    ItemFormProductSelected event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        productId: event.productId,
        productIdError: '',
      ),
    );
  }

  void _onQuantityChanged(
    ItemFormQuantityChanged event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        quantity: event.quantity,
      ),
    );
  }

  void _onProductIdErrorChanged(
    ItemFormProductIdErrorChanged event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        productIdError: event.productIdError,
      ),
    );
  }
}
