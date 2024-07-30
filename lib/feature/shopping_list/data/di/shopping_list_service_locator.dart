import 'package:cooki/common/di/api_service_locator.dart';
import 'package:cooki/feature/shopping_list/data/remote/shopping_list_remote_source.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository.dart';

final shoppingListRemoteSource = ShoppingListRemoteSource(graphQlClient);
final shoppingListRepository = ShoppingListRepository(shoppingListRemoteSource);
