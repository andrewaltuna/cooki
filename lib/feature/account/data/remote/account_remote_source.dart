import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/account/data/model/user_output.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AccountRemoteSource {
  const AccountRemoteSource(this._graphQLClient);

  final GraphQLClient _graphQLClient;

  Future<UserOutput?> getUser() async {
    final response = await _graphQLClient.query(
      QueryOptions(
        document: gql(_getUserQuery),
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['getUser'];

        return UserOutput.fromJson(result);
      },
      onError: (error) {
        error.graphqlErrors.first.extensions?['code'];
        // TODO: add proper handling for user not found error
        return null;
      },
    );
  }

  Future<UserOutput> createUser(String name) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_createUserMutation),
        variables: {
          'createUserInput': {
            'name': name,
          },
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['createUser'];

        return UserOutput.fromJson(result);
      },
      onError: (error) {
        throw Exception(error.toString());
      },
    );
  }
}

const _getUserQuery = r'''
  query GetUser {
    getUser {
      name
      userId
      preferences {
        dietary_restrictions {
          restriction_name
        }
        brand {
          brand_name
        }
        general {
          general_name
        }
        medication {
          brand_name
          generic_name
        }
        promo_notifications
        updatedAt
      }
      createdAt
      hasSeenInitialPreferencesModal
      profilePicture
    }
  }
''';

const _createUserMutation = r'''
  mutation CreateUser($createUserInput: CreateUserInput!) {
    createUser(createUserInput: $createUserInput) {
      name
      userId
      preferences {
        brand {
          brand_name
        }
        general {
          general_name
        }
        medication {
          brand_name
          generic_name
        }
        promo_notifications
        updatedAt
      }
      createdAt
      hasSeenInitialPreferencesModal
      profilePicture
    }
  }
''';
