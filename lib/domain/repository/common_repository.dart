import '../entities/common_entity.dart';

abstract class CommonRepository {
  Future<ClassWithDetailsRes> getClassesWithDetails();
}
