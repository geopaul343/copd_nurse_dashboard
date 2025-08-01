

abstract class DashBoardRepo{

  Future searchUser({required String name});

  Future fetchPatientCheckupData({required String patientId});
}