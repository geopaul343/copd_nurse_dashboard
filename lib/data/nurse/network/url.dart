
import 'package:admin_dashboard/env/env.dart';



class Urls{
  static var apiUrl = '${Env.instance.domainUrl}/api/';


  static const String login = 'login';
  static const String search = 'users/search';
  static const String getPatientCheckUp = 'admin/get-user-details';
  static const String getPatientCheckUpById = 'admin/get-all-user-details';

  //Admin
  static const String apiLogin = '/admin/login';
  static const String getAllPatients = 'admin/get-user-users';
  static const String getAllNurses = 'admin/get-all-nurses';
  static const String apiAssignPatientToNurse = '/admin/set-patient';


}