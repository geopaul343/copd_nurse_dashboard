import '../../../../app/app_constants.dart';
import '../../../../app/helper/helper.dart';
import '../../../../app/helper/shared_preference_helper.dart';
import '../../../../di/di.dart';
import '../../model/nurse/search_user_model.dart';
import '../../network/dio_client.dart';
import '../../network/exceptions.dart';
import '../../network/url.dart';
import 'admin_repo.dart';

class AdminRepoImpl extends AdminRepo{

  final _dio = getIt.get<DioClient>();
  @override
  Future getAllNurses() async{
    final Map<String, dynamic> queryParams = {
      'admin_id':  SharedPrefService.instance.getString(AppConstants.userId),

    };
    try{
      final response = await _dio.get(
          Urls.getAllNurses,
          queryParameters: queryParams
      );
      return response;
    }catch (e){
      print("Erorr ====>wwwww ${e.toString()}");
      throw ApiException(e);

    }
  }

  @override
  Future getAllPatients() async{
    final Map<String, dynamic> queryParams = {
      'admin_id':  SharedPrefService.instance.getString(AppConstants.userId),
    };
    try{
      final response = await _dio.get(
          Urls.getAllNurses,
          queryParameters: queryParams
      );
      final cleanedData = AppHelper().cleanJsonResponse(response.data);
      return SearchResponse.fromJson(cleanedData);
    }catch (e){
      print("Erorr ====>wwwww ${e.toString()}");
      throw ApiException(e);

    }
  }

  @override
  Future getNurseDetailById() async{
    final Map<String, dynamic> queryParams = {
      'admin_id':  SharedPrefService.instance.getString(AppConstants.userId),
    };
    try{
      final response = await _dio.get(
          Urls.getPatientCheckUp,
          queryParameters: queryParams
      );
      return response;
    }catch (e){
      print("Erorr ====>wwwww ${e.toString()}");
      throw ApiException(e);

    }
  }

  @override
  Future setPatientToNurse({required String nurseId, required List<String> userIds}) async{
    final Map<String, dynamic> queryParams = {
      'admin_id':  SharedPrefService.instance.getString(AppConstants.userId),
      'user_ids': userIds,
      'nurseId': nurseId
    };
    try{
      final response = await _dio.post(
          Urls.apiAssignPatientToNurse,
          data: queryParams
      );
      return response;
    }catch (e){
      print("Erorr ====>wwwww ${e.toString()}");
      throw ApiException(e);

    }
  }

}