import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChatRemoteSource {
  const ChatRemoteSource(this._graphQlClient);

  final GraphQLClient _graphQlClient;

  // Example only, API might be removed in the future
  Future<String> chat(String input) async {
    final response = await _graphQlClient.query(
      QueryOptions(
        document: gql(_createGeminiHealthCheckMutation),
        variables: {
          'input': input,
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['chat'] as Map<String, dynamic>;

        return result['message'] as String;
      },
    );
  }
}

const _createGeminiHealthCheckMutation = r'''
  mutation chat($input: String!) {
    chat(message: $input) {
      message
    }
  }
''';
