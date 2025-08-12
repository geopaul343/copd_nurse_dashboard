


import 'package:admin_dashboard/app/app_constants.dart';
import 'package:admin_dashboard/app/helper/helper.dart';
import 'package:admin_dashboard/app/helper/shared_preference_helper.dart';
import 'package:admin_dashboard/data/nurse/network/exceptions.dart';
import 'package:admin_dashboard/data/nurse/repository/dashboard/dashboard_repo.dart';
import 'package:admin_dashboard/di/di.dart';

import '../../model/nurse/patient_checkup_data_model.dart';
import '../../model/nurse/search_user_model.dart';
import '../../network/dio_client.dart';
import '../../network/url.dart';

class DashBoardRepoImpl extends DashBoardRepo{

  final _dio = getIt.get<DioClient>();


  @override
  Future searchUser({required String name}) async{
    final queryParams = {
      'name': name,
      'page_size': '10',
    };
   try{
     final response = await _dio.get(
         Urls.search,
         queryParameters: queryParams
     );
       //return SearchResponse.fromJson(response.data); // Use this with Google Cloud API
     final cleanedData = AppHelper().cleanJsonResponse(response.data);
     return SearchResponse.fromJson(cleanedData);
   }catch (e){
     print("Erorr ====> ${e.toString()}");
   }
  }

  @override
  Future fetchPatientCheckupData({required String patientId}) async{


    final Map<String, dynamic> queryParams = {
      'user_id': patientId,
      'admin_id':  SharedPrefService.instance.getString(AppConstants.userId),

    };
    try{
      final response = await _dio.get(
          Urls.getPatientCheckUp,
          queryParameters: queryParams
      );
   return PatientCheckUpDataModel.fromJson(response.data);
    }catch (e){
      print("Erorr ====>wwwww ${e.toString()}");
      throw ApiException(e);

    }
  }

  @override
  Future fetchPatientCheckupDataById() async{
    final Map<String, dynamic> queryParams = {
      'admin_id':  SharedPrefService.instance.getString(AppConstants.userId),

    };
    try{
      final response = await _dio.get(
          Urls.getPatientCheckUpById,
          queryParameters: queryParams
      );
      return PatientCheckUpDataModel.fromJson(response.data);
    }catch (e){
      print("Erorr ====>wwwww ${e.toString()}");
      throw ApiException(e);

    }
  }

}