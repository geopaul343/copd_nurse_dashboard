import 'package:dio/dio.dart';

import '../../env/env.dart';
import '../../env/production_env.dart';


class ApiException implements Exception {
  final dynamic error;
  ApiException([this.error]);

  bool get isProduction =>
      Env.instance.toString() == ProductionEnv().toString();

  final String somethingWrong = "Something went wrong! please try again!";

  @override
  String toString() {
    if (error == null) return "Exception";
    if (error is String) {
      return error as String;
    }
    if (error is Exception) {
      try {
        if (error is DioException) {
          // if (isProduction) {
          //   return somethingWrong;
          // }
          switch (error.type) {
            case DioExceptionType.cancel:
              return "Request to server was cancelled";
            case DioExceptionType.connectionError:
              return "Connection timeout with server";

            case DioExceptionType.unknown:
              return "Connection to server failed due to internet connection";

            case DioExceptionType.receiveTimeout:
              return "Receive timeout in connection with server";

            case DioExceptionType.badResponse:
              switch (error.response.statusCode) {
                case 500:
                case 503:
                  return error.response.statusMessage;

                case 404:
                  if (error?.response?.data['error'] != null) {
                    return error.response.data['error'].toString();
                  } else {
                    return "Failed to load data - status code: ${error.response.statusCode}";
                  }

                default:
                  print("${error?.response?.data['error']}uuuuuu");
                  if (error?.response?.data['message'] != null) {
                    return error.response.data['message'].toString();
                  } else {
                    return "Failed to load data - status code: ${error.response.statusCode}";
                  }
              }
            case DioExceptionType.sendTimeout:
              return "Send timeout with server";
          }
        } else {
          return "Unexpected error occurred";
        }
      } on FormatException catch (e) {
        return  somethingWrong;
        return e.toString();
      }
    } else {
      return 'Something went wrong! Could not connect to server';
    }
    return 'Something went wrong! Could not connect to server';
  }
}
