
import 'dart:async';

import 'package:admin_dashboard/ui/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

import '../../../app/app_constants.dart';
import '../../../data/nurse/model/admin/admin_patients_list_model.dart';
import '../../../data/nurse/model/admin/nurse_list_model.dart';
import '../../../data/nurse/repository/admin/admin_repo_impl.dart';




class AdminBloc{
  AdminRepoImpl repo = AdminRepoImpl();
final StreamController<NurseDetailModel> _nurseStreamController = StreamController<NurseDetailModel>.broadcast();
Stream<NurseDetailModel> get nurseListStream => _nurseStreamController.stream;

  final StreamController<List<AdminPatientsListModel>> _nursePatientsStreamController = StreamController<List<AdminPatientsListModel>>.broadcast();
  Stream<List<AdminPatientsListModel>> get nursePatientsListStream => _nursePatientsStreamController.stream;

  final StreamController<List<AdminPatientsListModel>> _nurseAssignedPatientsStreamController = StreamController<List<AdminPatientsListModel>>.broadcast();
  Stream<List<AdminPatientsListModel>> get nurseAssignedPatientsListStream => _nurseAssignedPatientsStreamController.stream;

  List<AdminPatientsListModel> patientListByNurseId =[];

  Future getAllNurses()async{
    try{
      NurseDetailModel result = await repo.getAllNurses();
      _nurseStreamController.add(result);
      print(result);
    }catch(e){
      print("Errorr===>$e");
      _nurseStreamController.addError(e);
    }
  }

  Future getAllPatients()async{
    try{
      List<AdminPatientsListModel> result = await repo.getAllPatients();
      patientListByNurseId.addAll(result);
      _nursePatientsStreamController.add(result);
    }catch(e){
      print("Errorr===>$e");
      _nursePatientsStreamController.addError(e);
    }
  }

  Future getPatientsByNurseId({required String nurseId})async{
    try{
      List<AdminPatientsListModel> result = await repo.getNurseDetailById(nurseId:nurseId);
      _nurseAssignedPatientsStreamController.add(result);
      print(result);
    }catch(e){
      print("Errorr===>$e");
      _nurseAssignedPatientsStreamController.addError(e);
    }
  }

  Future setPatientToNurse({required String nurseId, required List<String> userIds})async{
    try{
      String result = await repo.setPatientToNurse(nurseId: nurseId, userIds: userIds);
      print("message===>${result}");
      Navigator.pop(AppConstants.globalNavigatorKey.currentContext!,true);
    }catch(e){
     print("Erorr===>$e");
    }
  }

  bool isSetPatientToNurse({required List<String> userIds}){
    if(userIds.isEmpty){
      SnackBarCustom.failure("Select patient");
      return false;
    }
    return true;
  }

}