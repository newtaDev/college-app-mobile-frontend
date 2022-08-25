import 'package:dartz/dartz.dart';

import '../../shared/errors/api_errors.dart';
import '../entities/common_entity.dart';

abstract class CommonRepository {
  Future<Either<ClassWithDetailsRes, ApiErrorRes>> getClassesWithDetails();
}
