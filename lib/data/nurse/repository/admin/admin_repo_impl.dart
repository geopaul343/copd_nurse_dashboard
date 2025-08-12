import '../../../../app/app_constants.dart';
import '../../../../app/helper/helper.dart';
import '../../../../app/helper/shared_preference_helper.dart';
import '../../../../di/di.dart';
import '../../model/admin/admin_patients_list_model.dart';
import '../../model/admin/nurse_list_model.dart';
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
      return NurseDetailModel.fromJson(response.data);
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
          Urls.getAllPatients,
          queryParameters: queryParams
      );
      if (response.data != null && response.data["users"] is List) {
        return (response.data["users"] as List)
            .map((json) => AdminPatientsListModel.fromJson(json))
            .toList();
      } else {
        throw ApiException('Invalid response format: No users found');
      }
    }catch (e){
      print("Erorr ====>wwwww ${e.toString()}");
      throw ApiException(e);

    }
  }

  @override
  Future getNurseDetailById({required String nurseId}) async{
    final Map<String, dynamic> queryParams = {
      'admin_id':  SharedPrefService.instance.getString(AppConstants.userId),
      'nurse_id':  nurseId
    };
    try{
      final response = await _dio.get(
          Urls.getPatientsByNurseId,
          queryParameters: queryParams
      );
      return (response.data["users"] as List)
          .map((json) => AdminPatientsListModel.fromJson(json))
          .toList();
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
      'nurse_id': nurseId
    };
    try{
      final response = await _dio.post(
          Urls.apiAssignPatientToNurse,
          data: queryParams
      );
      return response.data["message"];
    }catch (e){
      print("Erorr ====>wwwww ${e.toString()}");
      throw ApiException(e);

    }
  }

}