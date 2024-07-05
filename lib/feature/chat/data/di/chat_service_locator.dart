import 'package:cooki/common/di/api_service_locator.dart';
import 'package:cooki/feature/chat/data/remote/chat_remote_source.dart';
import 'package:cooki/feature/chat/data/repository/chat_repository.dart';

final chatRemoteSource = ChatRemoteSource(graphQlClient);
final chatRepository = ChatRepository(chatRemoteSource);
