import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/shopping_list/data/remote/shopping_list_dummy_data.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductRemoteSource {
  const ProductRemoteSource(this._graphQLClient);

  final GraphQLClient _graphQLClient;
  Future<List<ProductOutput>> getProducts() async {
    final data = dummyData.products;

    return data
        .map((d) => ProductOutput(
              id: d.id,
              category: d.category,
              section: d.section,
              brand: d.brand,
              keyIngredients: d.keyIngredients,
              description: d.description,
              price: d.price,
              unitSize: d.unitSize,
            ))
        .toList();
  }

  Future<ProductOutput> getProduct(String id) async {
    final data = dummyData.products.firstWhere((element) => element.id == id);
    return ProductOutput(
      id: data.id,
      category: data.category,
      section: data.section,
      brand: data.brand,
      keyIngredients: data.keyIngredients,
      description: data.description,
      price: data.price,
      unitSize: data.unitSize,
    );
  }
}
