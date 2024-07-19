// TODO: Remove once queries are set up (just used for visualization)
import 'package:cooki/feature/preferences/data/enum/product_category.dart';

class RawProduct {
  const RawProduct({
    required this.id,
    required this.category,
    required this.section,
    required this.brand,
    required this.keyIngredients,
    required this.description,
    required this.price,
    required this.unitSize,
  });

  final String id;
  final ProductCategory category;
  final String section;
  final String brand;
  final List<String> keyIngredients;
  final String description;
  final double price;
  final String unitSize;
}

class RawShoppingListItem {
  const RawShoppingListItem({
    required this.id,
    required this.label,
    required this.productId,
    required this.quantity,
    required this.isChecked,
  });

  final String id;
  final String label;
  final String productId;
  final int quantity;
  final bool isChecked;
}

class RawShoppingList {
  const RawShoppingList({
    required this.id,
    required this.name,
    required this.budget,
    required this.itemIds,
  });

  final String id;
  final String name;
  final double budget;
  final List<String> itemIds;
}

class ShoppingListDummyData {
  final List<RawProduct> products = <RawProduct>[
    const RawProduct(
      id: 'dummy-1',
      category: ProductCategory.bakery,
      section: 'dummy_section-1',
      brand: 'dummy_brand-1',
      keyIngredients: ['dummy_ingredient-1', 'dummy_ingredient-1'],
      description: 'dummy description',
      price: 10.99,
      unitSize: 'dummy unit size',
    ),
    const RawProduct(
      id: 'dummy-2',
      category: ProductCategory.beverages,
      section: 'dummy_section-2',
      brand: 'dummy_brand-2',
      keyIngredients: ['dummy_ingredient-2', 'dummy_ingredient-2'],
      description: 'dummy description',
      price: 12.99,
      unitSize: 'dummy unit size',
    ),
    const RawProduct(
      id: 'dummy-3',
      category: ProductCategory.dairy,
      section: 'dummy_section-3',
      brand: 'dummy_brand-3',
      keyIngredients: ['dummy_ingredient-3', 'dummy_ingredient-3'],
      description: 'dummy description',
      price: 13.99,
      unitSize: 'dummy unit size',
    ),
    const RawProduct(
      id: 'dummy-4',
      category: ProductCategory.deli,
      section: 'dummy_section-4',
      brand: 'dummy_brand-4',
      keyIngredients: ['dummy_ingredient-4', 'dummy_ingredient-4'],
      description: 'dummy description',
      price: 14.99,
      unitSize: 'dummy unit size',
    ),
    const RawProduct(
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

  List<RawShoppingListItem> shoppingListItems = <RawShoppingListItem>[
    const RawShoppingListItem(
      id: '1',
      label: 'dummy item 1',
      productId: 'dummy-1',
      quantity: 1,
      isChecked: false,
    ),
    const RawShoppingListItem(
      id: '2',
      label: 'dummy item 2',
      productId: 'dummy-2',
      quantity: 1,
      isChecked: false,
    ),
    const RawShoppingListItem(
      id: '3',
      label: 'dummy item 3',
      productId: 'dummy-3',
      quantity: 1,
      isChecked: false,
    ),
    const RawShoppingListItem(
      id: '4',
      label: 'dummy item 4',
      productId: 'dummy-4',
      quantity: 1,
      isChecked: false,
    ),
    const RawShoppingListItem(
      id: '5',
      label: 'dummy item 5',
      productId: 'dummy-5',
      quantity: 1,
      isChecked: false,
    ),
    const RawShoppingListItem(
      id: '6',
      label: 'dummy item 6',
      productId: 'dummy-1',
      quantity: 1,
      isChecked: false,
    ),
    const RawShoppingListItem(
      id: '7',
      label: 'dummy item 7',
      productId: 'dummy-2',
      quantity: 1,
      isChecked: false,
    ),
  ];

  List<RawShoppingList> shoppingLists = <RawShoppingList>[
    const RawShoppingList(
      id: '1',
      name: 'Weekly Groceries',
      budget: 980.00,
      itemIds: ['1', '2', '3'],
    ),
    const RawShoppingList(
      id: '2',
      name: 'Weekly Dinner',
      budget: 1023.00,
      itemIds: ['4', '5', '6', '7'],
    ),
  ];
}

final dummyData = ShoppingListDummyData();
