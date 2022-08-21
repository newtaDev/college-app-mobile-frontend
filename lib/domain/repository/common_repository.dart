import 'package:dartz/dartz.dart';

import '../../data/models/response/class_with_details_res.dart';
import '../../shared/errors/api_errors.dart';

abstract class CommonRepository {
  Future<Either<ClassWithDetailsRes, ApiErrorRes>> getClassesWithDetails();
}
