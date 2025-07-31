import 'package:get_it/get_it.dart';

import '../data/network/dio_client.dart';

final getIt = GetIt.instance;

void setup() {


  // Register NetworkClient
  getIt.registerLazySingleton<DioClient>(() => DioClient());

}

// final _dio = getIt.get<DioClient>();