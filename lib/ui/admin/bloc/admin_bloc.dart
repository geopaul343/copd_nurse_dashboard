
import '../../../data/nurse/repository/admin/admin_repo_impl.dart';

class AdminBloc{

  AdminRepoImpl repo = AdminRepoImpl();


  Future getAllNurses()async{
    try{
      var result = repo.getAllNurses();
      print(result);
    }catch(e){
      print("Errorr===>$e");
    }
  }

}