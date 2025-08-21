import '../../../../app/app_constants.dart';
import '../../../../app/helper/shared_preference_helper.dart';
import '../../../../di/di.dart';
import '../../network/dio_client.dart';
import '../../network/url.dart';
import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final _dio = getIt.get<DioClient>();

  @override
  Future login({
    required String email,
    required String userId,
    required String userName,
  }) async {
    final queryParams = {
      'user_name': userName,
      'email': email,
      'user_id': userId,
      'user_type': SharedPrefService.instance.getInt(AppConstants.userType),
    };
    try {
      final response = await _dio.post(Urls.apiLogin, data: queryParams);
      //return SearchResponse.fromJson(response.data); // Use this with Google Cloud API
      return response;
    } catch (e) {
      print("Erorr ====> ${e.toString()}");
    }
  }
}
