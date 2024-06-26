import 'package:grocery_helper/feature/account/data/repository/auth_repository.dart';
import 'package:grocery_helper/feature/account/data/service/auth_service.dart';

final authService = AuthService();
final authRepository = AuthRepository(authService);
