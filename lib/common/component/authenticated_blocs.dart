import 'package:cooki/feature/map/data/di/map_service_locator.dart';
import 'package:cooki/feature/map/presentation/view_model/map_view_model.dart';
import 'package:cooki/feature/beacon/data/di/beacon_service_locator.dart';
import 'package:cooki/feature/beacon/presentation/view_model/beacon_view_model.dart';
import 'package:cooki/feature/chat/data/di/chat_service_locator.dart';
import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:cooki/feature/preferences/data/di/preferences_service_locator.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:cooki/feature/product/data/di/product_service_locator.dart';
import 'package:cooki/feature/product/presentation/view_model/product_event.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/di/shopping_list_service_locator.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Semi-global blocs that are only provided once user is authenticated.
class AuthenticatedBlocs extends StatelessWidget {
  const AuthenticatedBlocs({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => BeaconViewModel(beaconRepository)
            ..add(const BeaconSubscriptionInitialized())
            ..add(const BeaconPermissionsValidated()),
        ),
        BlocProvider(
          create: (_) => MapViewModel(mapRepository)
            ..add(
              const MapInitialized(),
            ),
        ),
        BlocProvider(
          create: (_) => ChatViewModel(chatRepository),
        ),
        BlocProvider(
          create: (_) => PreferencesViewModel(preferencesRepository)
            ..add(const PreferencesRequested()),
        ),
        BlocProvider(
            create: (_) => ShoppingListCatalogViewModel(shoppingListRepository)
              ..add(const ShoppingListCatalogRequested())),
        BlocProvider(
          create: (_) => ProductViewModel(productRepository)
            ..add(const ProductsRequested()),
          // Fetch early since we don't have any write operations
          // and its needed on multiple screens
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
