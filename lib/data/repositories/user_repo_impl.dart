import 'package:dio/dio.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../../shared/global/enums.dart';
import '../data_source/remote/user_rds.dart';

class UserRepoImpl implements UserRepository {
  final UserRemoteDataSource userRds;

  UserRepoImpl({required this.userRds});
  @override
  Future<UserDetailsRes> getUserDetails() async {
    try {
      final res = await userRds.getUserDetails();
      return UserDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDetails> updateUser() {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
