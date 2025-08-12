
import 'dart:async';

import '../../../data/nurse/model/admin/nurse_list_model.dart';
import '../../../data/nurse/repository/admin/admin_repo_impl.dart';

class AdminBloc{

  AdminRepoImpl repo = AdminRepoImpl();

final StreamController<NurseDetailModel> _nurseStreamController = StreamController<NurseDetailModel>.broadcast();
Stream<NurseDetailModel> get nurseListStream => _nurseStreamController.stream;

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

}