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
    on<ItemFormProductSelected>(_onProductSelected);
    on<ItemFormLabelChanged>(_onLabelChanged);
    on<ItemFormQuantityChanged>(_onQuantityChanged);
    on<ItemFormLabelErrorChanged>(_onLabelErrorChanged);
    on<ItemFormQuantityErrorChanged>(_onQuantityErrorChanged);
    on<ItemFormProductIdErrorChanged>(_onProductIdErrorChanged);
  }

  void _onInitialized(
    ItemFormInitialized event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        status: ViewModelStatus.success,
        label: event.label,
        productId: event.productId,
        quantity: event.quantity,
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
      ),
    );
  }

  void _onLabelChanged(
    ItemFormLabelChanged event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        label: event.label,
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

  void _onLabelErrorChanged(
    ItemFormLabelErrorChanged event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        labelError: event.labelError,
      ),
    );
  }

  void _onQuantityErrorChanged(
    ItemFormQuantityErrorChanged event,
    Emitter<ShoppingListItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        quantityError: event.quantityError,
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
