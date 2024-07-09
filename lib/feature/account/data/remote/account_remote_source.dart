import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/account/data/model/input/edit_user_profile_input.dart';
import 'package:cooki/feature/account/data/model/output/user_output.dart';
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

  Future<UserOutput> editUserProfile(
    EditUserProfileInput input,
  ) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_editUserProfileMutation),
        variables: {
          'editUserProfileInput': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['editUserProfile'];

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
      userId
      name
      hasSeenInitialPreferencesModal
    }
  }
''';

const _createUserMutation = r'''
  mutation CreateUser($createUserInput: CreateUserInput!) {
    createUser(createUserInput: $createUserInput) {
      userId
      name
      hasSeenInitialPreferencesModal
    }
  }
''';

const _editUserProfileMutation = r'''
  mutation EditUserProfile($input: EditUserProfileInput!) {
    editUserProfile(editUserProfileInput: $input) {
      name
      userId
      hasSeenInitialPreferencesModal
    }
  }
''';
