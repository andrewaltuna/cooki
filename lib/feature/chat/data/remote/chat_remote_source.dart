import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/chat/data/model/chat_message.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChatRemoteSource {
  const ChatRemoteSource(this._graphQlClient);

  final GraphQLClient _graphQlClient;

  Future<ChatMessage> chat(
    String message,
    bool isFirstMessage,
  ) async {
    final response = await _graphQlClient.query(
      QueryOptions(
        document: gql(_chatQuery),
        variables: {
          'message': message,
          'isFirstMessage': isFirstMessage,
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['chat'] as Map<String, dynamic>?;

        if (result == null) throw Exception('Invalid response');

        return ChatMessage.fromJson(result);
      },
    );
  }
}

const _chatQuery = r'''
  query chat($message: String!, $isFirstMessage: Boolean!) {
    chat(message: $message, isFirstMessage: $isFirstMessage) {
      message
      products {
        productId
        quantity
      }
    }
  }
''';
