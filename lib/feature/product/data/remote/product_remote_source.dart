import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/product/data/model/product.dart';
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

    return response.result(
      onSuccess: (data) {
        final result = List<Map<String, dynamic>>.from(data['products']);

        return result.map(Product.fromJson).toList();
      },
    );
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

    return response.result(
      onSuccess: (data) {
        final result = Map<String, dynamic>.from(data['product']);

        return Product.fromJson(result);
      },
    );
  }
}

const productsOutputFragment = r'''
  fragment ProductsOutputFragment on ProductsOutput {
    _id
    brand
    name
    description
    imageUrl
    manufacturer {
      name
      certificates
    }
    productCategory
    price
    section
    unitSize
  }
''';

const _getProductsQuery = productsOutputFragment +
    r'''
      query getProducts {
        products {
          ...ProductsOutputFragment    
        }
      }
    ''';

const _getProductQuery = productsOutputFragment +
    r'''
      query getProduct($id: String!) {
        product(_id: $id) {
          ...ProductsOutputFragment    
        }
      }
    ''';
