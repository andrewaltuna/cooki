import 'package:cooki/common/di/api_service_locator.dart';
import 'package:cooki/feature/product/data/remote/product_remote_source.dart';
import 'package:cooki/feature/product/data/repository/product_repository.dart';

final productRemoteSource = ProductRemoteSource(graphQlClient);
final productRepository = ProductRepository(productRemoteSource);
