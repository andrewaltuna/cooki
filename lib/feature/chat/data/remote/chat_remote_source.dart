import 'package:graphql_flutter/graphql_flutter.dart';

class ChatRemoteSource {
  const ChatRemoteSource(this._graphQlClient);

  final GraphQLClient _graphQlClient;

  // Example only, API might be removed in the future
  Future<String> createGeminiHealthCheck(String input) async {
    final response = await _graphQlClient.query(
      QueryOptions(
        document: gql(_createGeminiHealthCheckMutation),
        variables: {
          "createGeminiHealthCheckInput": {
            "input": input,
          },
        },
      ),
    );

    return response.data!['createGeminiHealthCheck'] as String;
  }
}

const _createGeminiHealthCheckMutation = r'''
  mutation createGeminiHealthCheck($createGeminiHealthCheckInput: CreateGeminiHealthCheckInput!) {
    createGeminiHealthCheck(createGeminiHealthCheckInput: $createGeminiHealthCheckInput) 
  }
''';
