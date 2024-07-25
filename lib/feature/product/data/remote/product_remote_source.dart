import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/shopping_list/data/remote/shopping_list_dummy_data.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductRemoteSource {
  const ProductRemoteSource(this._graphQLClient);

  final GraphQLClient _graphQLClient;
  Future<List<Product>> getProducts() async {
    final response = await _graphQLClient.query(
      QueryOptions(
        document: gql(_getProductsQuery),
      ),
    );

    return response.result(onSuccess: (data) {
      final result = new List<Map<String, dynamic>>.from(data['products']);

      final productData = result.map(Product.fromJson).toList();
      return productData;
    });

    // final data = dummyData.products;

    // return data
    //     .map((d) => ProductOutput(
    //           id: d.id,
    //           category: d.category,
    //           section: d.section,
    //           brand: d.brand,
    //           keyIngredients: d.keyIngredients,
    //           description: d.description,
    //           price: d.price,
    //           unitSize: d.unitSize,
    //         ))
    //     .toList();
  }

  Future<Product> getProduct(String id) async {
    final response = await _graphQLClient.query(
      QueryOptions(
        document: gql(_getProductQuery),
        variables: {
          'id': id,
        },
      ),
    );

    return response.result(onSuccess: (data) {
      // TODO: Return data
      final result = new Map<String, dynamic>.from(data['product']);
      final productData = Product.fromJson(result);
      return productData;
    });

    //
  }
}

const _getProductsQuery = r'''
  query getProducts {
    products {
      _id
      productCategory
      section
      brand
      key_ingredients
      description
      price
      unitSize
      manufacturer
    }
  }
''';

const _getProductQuery = r'''
  query getProduct($id: String!) {
    product(id: $id) {
      _id
      productCategory
      section
      brand
      key_ingredients
      description
      price
      unitSize
      manufacturer
    }
  }
''';
