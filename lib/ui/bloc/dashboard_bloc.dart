import 'dart:async';

import 'package:admin_dashboard/data/model/search_user_model.dart';

import '../../data/repository/dashboard/dashboard_repo_impl.dart';

class DashboardBloc{

  final DashBoardRepoImpl _repo = DashBoardRepoImpl();

  final StreamController<List<PatientUser>> _searchController = StreamController<List<PatientUser>>();
  Stream<List<PatientUser>> get searchStream => _searchController.stream;

  Future searchUser({required String name}) async {
    try{
     SearchResponse response = await _repo.searchUser(name: name);
     if(response.users.isNotEmpty){
       _searchController.sink.add(response.users);
     }else{
      _searchController.addError('No users found');
     }
    }catch (e){
       _searchController.addError('something went wrong');
      }
  }

}