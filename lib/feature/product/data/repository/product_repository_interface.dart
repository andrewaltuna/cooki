import 'package:cooki/feature/product/data/model/product.dart';

abstract interface class ProductRepositoryInterface {
  Future<List<Product>> getProducts();
  Future<Product> getProduct(String id);
}
