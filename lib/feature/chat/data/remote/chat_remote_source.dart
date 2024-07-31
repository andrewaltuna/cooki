import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/chat/data/model/chat_message.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChatRemoteSource {
  const ChatRemoteSource(this._graphQlClient);

  final GraphQLClient _graphQlClient;

  // Example only, API might be removed in the future
  Future<ChatMessage> chat(String input) async {
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

        return ChatMessage.fromJson(result);
      },
    );
  }
}

const _createGeminiHealthCheckMutation = r'''
  mutation chat($input: String!) {
    chat(message: $input) {
      message
      products {
        _id
        productCategory
        section
        brand
        key_ingredients
        description
        price
        unitSize
        manufacturer
      }
    }
  }
''';
