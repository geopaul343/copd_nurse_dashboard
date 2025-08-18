import 'dart:async';
import 'package:admin_dashboard/data/nurse/model/nurse/patient_checkup_data_model.dart';
import 'package:admin_dashboard/data/nurse/repository/dashboard/dashboard_repo_impl.dart';
import '../../../data/nurse/model/nurse/search_user_model.dart';




class DashboardBloc {
  final DashBoardRepoImpl _repo = DashBoardRepoImpl();
  final StreamController<List<PatientUser>> _searchController =
      StreamController<List<PatientUser>>();
  Stream<List<PatientUser>> get searchStream => _searchController.stream;

  final StreamController<PatientCheckUpDataModel> _patientDataController =
      StreamController<PatientCheckUpDataModel>();
  Stream<PatientCheckUpDataModel> get patientDataStream =>
      _patientDataController.stream;

  Future searchUser({required String name}) async {
    try {
      SearchResponse response = await _repo.searchUser(name: name);
      if (response.users.isNotEmpty) {
        _searchController.sink.add(response.users);
      } else {
        _searchController.addError('No users found');
      }
    } catch (e) {
      _searchController.addError('something went wrong');
    }
  }

  Future getPatientCheckUpData({required String patientId}) async {
    try {
      PatientCheckUpDataModel response = await _repo.fetchPatientCheckupData(
        patientId: patientId,
      );
      _patientDataController.add(response);
    } catch (e) {
      _patientDataController.addError(e.toString());
    }
  }

  Future getPatientCheckUpDataById() async {
    try{
      PatientCheckUpDataModel response = await _repo.fetchPatientCheckupDataById();
      _patientDataController.add(response);
    }catch (e){
      _patientDataController.addError(e.toString());
    }
  }
}
