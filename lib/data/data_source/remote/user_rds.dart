import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';

class UserRemoteDataSource {
  final client = DioClient.getClient();

  /// `userId` and `userType` is taken from token
  Future<Response> getUserDetails() {
    return client.get('/user/details');
  }
}
