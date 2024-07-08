import 'package:cooki/common/di/api_service_locator.dart';
import 'package:cooki/feature/account/data/remote/account_remote_source.dart';
import 'package:cooki/feature/account/data/repository/account_repository.dart';

final accountRemoteSource = AccountRemoteSource(graphQlClient);
final accountRepository = AccountRepository(accountRemoteSource);
