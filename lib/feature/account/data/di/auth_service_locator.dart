import 'package:cooki/common/di/api_service_locator.dart';
import 'package:cooki/feature/account/data/remote/account_remote_source.dart';
import 'package:cooki/feature/account/data/repository/auth_repository.dart';
import 'package:cooki/feature/account/data/service/auth_service.dart';

final authService = AuthService();
final authRemoteSource = AccountRemoteSource(graphQlClient);
final authRepository = AuthRepository(authService);
