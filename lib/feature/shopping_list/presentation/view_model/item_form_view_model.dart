import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_form_event.dart';
part 'item_form_state.dart';

class ItemFormViewModel extends Bloc<ItemFormEvent, ItemFormState> {
  ItemFormViewModel() : super(const ItemFormState()) {
    on<ItemFormInitialized>(_onInitialized);
    on<ItemFormProductSelected>(_onProductSelected);
    on<ItemFormLabelChanged>(_onLabelChange);
    on<ItemFormQuantityChanged>(_onQuantityChange);
    on<ItemFormLabelErrorChanged>(_onLabelErrorChange);
    on<ItemFormQuantityErrorChanged>(_onQuantityErrorChange);
    on<ItemFormProductIdErrorChanged>(_onProductIdErrorChange);
  }

  void _onInitialized(
    ItemFormInitialized event,
    Emitter<ItemFormState> emit,
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
    Emitter<ItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        productId: event.productId,
      ),
    );
  }

  void _onLabelChange(
    ItemFormLabelChanged event,
    Emitter<ItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        label: event.label,
      ),
    );
  }

  void _onQuantityChange(
    ItemFormQuantityChanged event,
    Emitter<ItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        quantity: event.quantity,
      ),
    );
  }

  void _onLabelErrorChange(
    ItemFormLabelErrorChanged event,
    Emitter<ItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        labelError: event.labelError,
      ),
    );
  }

  void _onQuantityErrorChange(
    ItemFormQuantityErrorChanged event,
    Emitter<ItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        quantityError: event.quantityError,
      ),
    );
  }

  void _onProductIdErrorChange(
    ItemFormProductIdErrorChanged event,
    Emitter<ItemFormState> emit,
  ) {
    emit(
      state.copyWith(
        productIdError: event.productIdError,
      ),
    );
  }
}
