import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/preferences/data/model/input/update_preferences_input.dart';
import 'package:cooki/feature/preferences/data/model/output/preferences_output.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PreferencesRemoteSource {
  const PreferencesRemoteSource(this._client);

  final GraphQLClient _client;

  Future<PreferencesOutput> getPreferences() async {
    final response = await _client.query(
      QueryOptions(
        document: gql(_getPreferencesQuery),
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['getLatestPreference'];

        return PreferencesOutput.fromJson(result);
      },
    );
  }

  Future<PreferencesOutput> updatePreferences(
    UpdatePreferencesInput input,
  ) async {
    final response = await _client.mutate(
      MutationOptions(
        document: gql(_updatePreferencesMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['updatePreference'];

        return PreferencesOutput.fromJson(result);
      },
      onError: (error) {
        print(error);
        throw Exception();
      },
    );
  }
}

const _getPreferencesQuery = r'''
  query GetLatestPreference {
    getLatestPreference {
      dietary_restrictions {
        restriction_name
        key_ingredients {
          key_ingredient_name
        }
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
      createdAt
      updatedAt
    }
  }
''';

const _updatePreferencesMutation = r'''
  mutation UpdatePreference($input: PreferencesInput!) {
    updatePreference(preferenceInput: $input) {
      dietary_restrictions {
        restriction_name
        key_ingredients {
          key_ingredient_name
        }
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
      createdAt
      updatedAt
    }
  }
''';
