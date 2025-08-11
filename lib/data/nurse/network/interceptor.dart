import 'package:admin_dashboard/app/app_constants.dart';
import 'package:admin_dashboard/app/helper/shared_preference_helper.dart';

import 'package:admin_dashboard/ui/nurse/screens/auth/login_screen.dart';
import 'package:admin_dashboard/ui/nurse/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${SharedPrefService.instance.getString(AppConstants.accessToken)}',
      // 'Timestamp': _now.millisecondsSinceEpoch,
    });
    print(options.headers.toString());
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      //log("${jsonEncode(response.data)}wwwwwppppppppp");
      return response.statusCode == 200 || response.statusCode == 201
          ? super.onResponse(response, handler)
          : handler.reject(DioException(
          requestOptions: response.requestOptions,
          error: response.data,
          response: response,
          type: DioExceptionType.badResponse));
    } catch (e) {
      handler.reject(DioException(
        requestOptions: response.requestOptions,
        error: "Something went wrong",
        response: response,
        type: DioExceptionType.unknown,
      ));
    }
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    print("eroor===>${err.requestOptions.baseUrl}, ${err.requestOptions.data} ,${err.requestOptions.uri}");
    print("eroor===>11${err.message}, ${err.response?.data} ,${err.stackTrace}");
    if (err.response?.statusCode == 401) {
      SnackBarCustom.failure("Session Expired");
      await SharedPrefService.instance.clearPrefs();
      Navigator.pushReplacementNamed(AppConstants.globalNavigatorKey.currentContext!, LoginScreen.path);
    }
     super.onError(err, handler);
  }
}



// class TokenRefreshInterceptor extends Interceptor {
//   final Dio dio;

//   TokenRefreshInterceptor({required this.dio});

//   @override
//   void onError(DioException error, ErrorInterceptorHandler handler) async {
//     if (error.response?.statusCode == 401 &&
//         AppConstants.loggedUser?.accessToken != null) {
//       RequestOptions? options = error.response?.requestOptions;
//       Response resp;
//       try {
//         resp = await Dio().post(
//           Urls.apiUrl + Urls.tokenRefresh,
//           data: {"token": AppConstants.loggedUser?.refreshToken},
//           options: Options(
//             headers: options?.headers,
//           ),
//         );
//       } on DioException {
//         handler.reject(error);
//         await AuthBloc().clearSharedData();
//         return;
//       }
//       switch (resp.statusCode) {
//         case 200:
//           if (resp.data["access"] != null) {
//             AppConstants.loggedUser!.accessToken = resp.data["access"];
//             if (resp.data["refreshToken"] != null) {
//               AppConstants.loggedUser?.refreshToken = resp.data["refreshToken"];
//             }
//             AuthBloc().setUserToken(AppConstants.loggedUser!);
//             options?.headers["Authorization"] =
//                 "Bearer ${AppConstants.loggedUser?.accessToken}";

//             try {
//               // Retry the original request
//               var retryResponse = await dio.request(
//                 Urls.apiUrl + options!.path,
//                 data: options.data,
//                 options: Options(
//                   headers: options.headers,
//                   method: options.method,
//                 ),
//               );
//               handler.resolve(retryResponse);
//             } on DioError catch (e) {
//               handler.reject(e);
//               return AuthBloc().logout();
//             }
//           } else {
//             handler.next(error);
//             return AuthBloc().logout();
//           }
//           break;
//         default:
//           handler.reject(error);
//       }
//     } else {
//       handler.next(error);
//     }
//   }
// }
