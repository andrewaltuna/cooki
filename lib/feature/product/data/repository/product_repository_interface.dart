import 'package:cooki/feature/product/data/model/output/product_output.dart';

abstract interface class ProductRepositoryInterface {
  Future<List<ProductOutput>> getProducts();
  Future<ProductOutput> getProduct(String id);
}
