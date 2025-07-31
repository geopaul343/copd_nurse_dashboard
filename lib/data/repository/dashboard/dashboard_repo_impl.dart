
import 'dart:convert';

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
     if (response.statusCode == 200) {
       final data = jsonDecode(response.data);
       print(response.data);
       return data['access_token']; // Use this with Google Cloud API
     } else {
       print("Failed to exchange token: ${response.data}");
       return null;
     }
   }catch (e){
     print("sssss");
   }
  }

}