abstract class AdminRepo{

  Future getAllNurses();

  Future getAllPatients();

  Future setPatientToNurse({required String nurseId, required List<String> userIds});

  Future getNurseDetailById();
}