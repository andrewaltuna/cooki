import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/account/data/model/user_output.dart';
import 'package:cooki/feature/preferences/data/model/input/edit_user_profile_input.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PreferencesRemoteSource {
  const PreferencesRemoteSource(this._client);

  final GraphQLClient _client;

  Future<UserOutput> updateUserProfile(
    EditUserProfileInput input,
  ) async {
    final response = await _client.mutate(
      MutationOptions(
        document: gql(_updateUserProfileMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['editUserProfile'];

        return UserOutput.fromJson(result);
      },
      onError: (error) {
        print(error);
        throw Exception();
      },
    );
  }
}

const _updateUserProfileMutation = r'''
    mutation EditUserProfile($input: EditUserProfileInput!) {
      editUserProfile(editUserProfileInput: $input) {
        hasSeenInitialPreferencesModal
      }
    }
''';
