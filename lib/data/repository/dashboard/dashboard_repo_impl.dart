
import 'dart:convert';

import 'package:admin_dashboard/data/model/search_user_model.dart';
import 'package:admin_dashboard/data/repository/dashboard/dashboard_repo.dart';

import '../../../di/di.dart';
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
       return SearchResponse.fromJson(response.data); // Use this with Google Cloud API
   }catch (e){
     print("Erorr ====> ${e.toString()}");
   }
  }

}