import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/product/data/repository/product_repository_interface.dart';
import 'package:cooki/feature/product/presentation/view_model/product_event.dart';
import 'package:cooki/feature/product/presentation/view_model/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductViewModel extends Bloc<ProductEvent, ProductState> {
  ProductViewModel(this._repository) : super(const ProductState()) {
    on<ProductsRequested>(_onRequested);
    on<ProductRequested>(_onSelected);
  }

  final ProductRepositoryInterface _repository;

  Future<void> _onRequested(
    ProductsRequested event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: ViewModelStatus.loading,
      ));

      final result = await _repository.getProducts();

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          products: result,
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
      ProductRequested event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));
      final result = await _repository.getProduct(event.id);
      emit(
        state.copyWith(
            status: ViewModelStatus.success, selectedProduct: result),
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
