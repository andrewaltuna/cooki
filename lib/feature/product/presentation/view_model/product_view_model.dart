import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/product/data/repository/product_repository_interface.dart';
import 'package:cooki/feature/product/presentation/view_model/product_event.dart';
import 'package:cooki/feature/product/presentation/view_model/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductViewModel extends Bloc<ProductEvent, ProductState> {
  ProductViewModel(this._repository) : super(const ProductState()) {
    on<ProductsRequested>(_onRequested);
  }

  final ProductRepositoryInterface _repository;

  Future<void> _onRequested(
    ProductsRequested event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final products = await _repository.getProducts();
      final sections =
          products.map((product) => product.sectionLabel).toSet().toList();

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          sections: sections,
          products: products,
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
