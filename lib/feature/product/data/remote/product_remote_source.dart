import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final List<ProductOutput> dummyProducts = <ProductOutput>[
  const ProductOutput(
    id: 'dummy-1',
    category: ProductCategory.bakery,
    section: 'dummy_section-1',
    brand: 'dummy_brand-1',
    keyIngredients: ['dummy_ingredient-1', 'dummy_ingredient-1'],
    description: 'dummy description',
    price: 10.99,
    unitSize: 'dummy unit size',
  ),
  const ProductOutput(
    id: 'dummy-2',
    category: ProductCategory.beverages,
    section: 'dummy_section-2',
    brand: 'dummy_brand-2',
    keyIngredients: ['dummy_ingredient-2', 'dummy_ingredient-2'],
    description: 'dummy description',
    price: 12.99,
    unitSize: 'dummy unit size',
  ),
  const ProductOutput(
    id: 'dummy-3',
    category: ProductCategory.dairy,
    section: 'dummy_section-3',
    brand: 'dummy_brand-3',
    keyIngredients: ['dummy_ingredient-3', 'dummy_ingredient-3'],
    description: 'dummy description',
    price: 13.99,
    unitSize: 'dummy unit size',
  ),
  const ProductOutput(
    id: 'dummy-4',
    category: ProductCategory.deli,
    section: 'dummy_section-4',
    brand: 'dummy_brand-4',
    keyIngredients: ['dummy_ingredient-4', 'dummy_ingredient-4'],
    description: 'dummy description',
    price: 14.99,
    unitSize: 'dummy unit size',
  ),
  const ProductOutput(
    id: 'dummy-5',
    category: ProductCategory.frozen,
    section: 'dummy_section-5',
    brand: 'dummy_brand-5',
    keyIngredients: ['dummy_ingredient-5', 'dummy_ingredient-5'],
    description: 'dummy description',
    price: 15.99,
    unitSize: 'dummy unit size',
  ),
];

class ProductRemoteSource {
  const ProductRemoteSource(this._graphQLClient);

  final GraphQLClient _graphQLClient;
  Future<List<ProductOutput>> getProducts() async {
    return dummyProducts;
  }

  // TODO: Create dummy shopping list items with these data. Figure out how to store referenced data (either by ID or actual object)
  // Separate view model to handle states for shopping list item and product?
  Future<ProductOutput> getProduct(String id) async {
    return dummyProducts.firstWhere((element) => element.id == id);
  }
}
