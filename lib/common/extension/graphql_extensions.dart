import 'package:graphql_flutter/graphql_flutter.dart';

extension QueryResultExtension on QueryResult {
  T result<T>({
    required T Function(Map<String, dynamic> data) onSuccess,
    T Function(OperationException error)? onError,
  }) {
    final responseData = data;

    if (hasException) {
      final responseException = exception;

      if (responseException == null) {
        throw Exception('Exception is null');
      }

      if (onError != null) {
        return onError(responseException);
      }

      throw Exception(responseException.toString());
    }

    if (responseData == null) {
      throw Exception('Data is null');
    }

    return onSuccess(responseData);
  }
}
