import 'package:cooki/common/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final _authLink = AuthLink(
  getToken: () async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? '';

      return 'Bearer $token';
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
  cache: GraphQLCache(),
);
