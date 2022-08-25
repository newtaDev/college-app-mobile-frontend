import 'package:dio/dio.dart';

import '../../../shared/global/enums.dart';
import '../../../shared/helpers/network/dio_client.dart';

class ProfileRemoteDataSource {
  final client = DioClient.getClient();

  Future<Response> getProfileData({
    required String id,
    required UserType userType,
  }) {
    return client.get(
      '/user/profiles/$id',
      queryParameters: {'userType': userType.value},
    );
  }
}
