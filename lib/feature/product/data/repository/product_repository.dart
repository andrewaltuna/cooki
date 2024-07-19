import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/product/data/remote/product_remote_source.dart';
import 'package:cooki/feature/product/data/repository/product_repository_interface.dart';

class ProductRepository implements ProductRepositoryInterface {
  const ProductRepository(this._remoteSource);

  final ProductRemoteSource _remoteSource;

  @override
  Future<List<ProductOutput>> getProducts() {
    return _remoteSource.getProducts();
  }

  @override
  Future<ProductOutput> getProduct(String id) async {
    return _remoteSource.getProduct(id);
  }
}
