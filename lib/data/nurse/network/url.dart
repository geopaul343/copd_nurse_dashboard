
import 'package:admin_dashboard/env/env.dart';



class Urls{
  static var apiUrl = '${Env.instance.domainUrl}/api/';


  static const String login = 'login';
  static const String search = 'users/search';
  static const String getPatientCheckUp = 'admin/get-user-details';


}