import 'package:cooki/constant/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final _authLink = AuthLink(
  getToken: () async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? '';

      final bearerToken = 'Bearer $token';

      if (kDebugMode) {
        print('REQUEST WITH TOKEN: $bearerToken');
      }

      return bearerToken;
    } catch (error) {
      rethrow;
    }
  },
);

final _httpLink = HttpLink(
  '${AppConstants.apiGateway}/graphql',
);

final graphQlClient = GraphQLClient(
  link: _authLink.concat(_httpLink),
  defaultPolicies: DefaultPolicies(
    query: Policies.safe(
      FetchPolicy.networkOnly,
      ErrorPolicy.none,
      CacheRereadPolicy.ignoreAll,
    ),
  ),
  cache: GraphQLCache(),
);
