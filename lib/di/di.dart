
import 'package:admin_dashboard/data/nurse/network/dio_client.dart';
import 'package:get_it/get_it.dart';



final getIt = GetIt.instance;

void setup() {


  // Register NetworkClient
  getIt.registerLazySingleton<DioClient>(() => DioClient());

}

// final _dio = getIt.get<DioClient>();