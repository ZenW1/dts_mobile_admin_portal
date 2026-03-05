// import 'dart:async';
//
// import 'package:chopper/chopper.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
//
// class AuthenticationCheckerInterceptor implements Interceptor {
//   @override
//   FutureOr<Request> onRequest(Request request) {
//     final token = LocalService().getSavedValue(LocalDataFieldName.userToken) ?? "";
//     final modifiedRequest = applyHeaders(request, {
//       "Content-Type": "application/json; charset=utf-8",
//       "Accept": "application/json; charset=utf-8",
//       "Authorization": "Bearer $token",
//     });
//
//     try {
//       if (Env.shouldShowApiLog && modifiedRequest.headers.isNotEmpty || Env.isDebugging) GlobalService.logger.i(modifiedRequest.headers);
//       if (Env.shouldShowApiLog && modifiedRequest.parameters.isNotEmpty || Env.isDebugging) GlobalService.logger.i(modifiedRequest.parameters);
//       if (Env.shouldShowApiLog && modifiedRequest.body != null || Env.isDebugging) GlobalService.logger.i(modifiedRequest.body?.toJson());
//     } catch (error) {}
//
//     return modifiedRequest;
//   }
// }
//
// class AuthenticationResponseInterceptor implements ResponseInterceptor {
//   @override
//   FutureOr<Response> onResponse(Response response) {
//
//     final stopwatch = Stopwatch()..start();
//     if (response.isSuccessful == false && response.statusCode == 401) {
//       GlobalService().clearNavigationStack();
//       GlobalService().pushReplacementNavigation(BioSignInView());
//       Fluttertoast.showToast(msg: 'Your session has been expired!');
//     }
//
//     if( response.statusCode == 200){
//
//       stopwatch.stop();
//
//     }
//
//     try {
//       log('Response time for API (): ${stopwatch.elapsedMilliseconds}ms');
//
//       // if (Env.shouldShowApiLog || Env.isDebugging) GlobalService.logger.i('Time responsed ${stopwatch.elapsedMilliseconds}ms');
//
//       if (Env.shouldShowApiLog || Env.isDebugging) GlobalService.logger.i(response.body?.toJson());
//     } catch (error) {}
//
//     return response;
//   }
// }