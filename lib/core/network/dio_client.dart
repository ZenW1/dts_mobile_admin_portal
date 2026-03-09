import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:logger/logger.dart';


import '../../generated_code/swagger.swagger.dart';

//singleton class for DioClient
class ApiServiceProvider {
  static final ApiServiceProvider _instance = ApiServiceProvider._internal();
  late final Swagger restApi;

  factory ApiServiceProvider() => _instance;

  ApiServiceProvider._internal() {
    restApi = Swagger.create(
      baseUrl: Uri.parse('http://192.168.168.175:3000'),
      httpClient: null,
      // authenticator: MyAuthenticator(),
      interceptors: [
        MyRequestInterceptor(),
        MyResponseInterceptor(),
      ],
    );
  }
}

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: true,
    colors: true,
  ),
);

class MyRequestInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    // final storage = getIt<AppStorage>();
    // final token = storage.read(key: ConstantPreferenceKey.accessTokenKey);
    //
    // storage.clearWriteRequest();
    // storage.clearWritePayload();

    final request = applyHeader(chain.request, 'authorization' , ''
        // 'Bearer $token'
    );

    // storage.writeRequest(url: request.uri.toString(), params: request.body.toString());

    // check it socket time out
    if (request.uri.toString().contains('socket')) {
      return chain.proceed(request);
    }

    logger.i('====================START====================');
    logger.i('HTTP method => ${request.method}');
    logger.i('Path => ${request.uri}');
    logger.i('Params  => ${request.parameters}');
    return chain.proceed(request);
  }
}

class MyResponseInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    // final storage = getIt<AppStorage>();
    // final token = storage.read(key: ConstantPreferenceKey.accessTokenKey);

    // await storage.clearWritePayload();

    final request = applyHeader(
      chain.request,
      'authorization',
       ''
      // 'Bearer $token',
    );
    final response = await chain.proceed(request);

    // if (response.statusCode == 401) {
    //   storage.clearToken();
    //   getx.Get.offAll(() => const SplashScreen());
    // }

    // check if the socket time out

    if (request.uri.toString().contains('socket')) {
      return response;
    }

    // request path
    logger.d('Response => StatusCode: ${response.statusCode}'); // Debug log
    if (response.statusCode == 200) {
      logger.d('Response => Body: ${response.body}');
    } else {
      // storage.writePayload(payload: response.error.toString());

      logger.d('Response => Response Error Data: ${response.error}');
    }
    return response;
  }
}

class HeaderInterceptor implements HeadersInterceptor {
  @override
  // TODO: implement headers
  Map<String, String> get headers => {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json; charset=utf-8",
      };

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    return chain.proceed(chain.request);
  }
}

// class MyAuthenticator implements Authenticator {
//   @override
//   FutureOr<Request?> authenticate(Request request, Response response, [Request? originalRequest]) {
//     final header = {
//       "Content-Type": "application/json; charset=utf-8",
//       "Accept": "application/json; charset=utf-8",
//       // "Authorization": "Bearer ${getIt<AppStorage>().read(key: ConstantPreferenceKey.accessTokenKey)}",
//     };
//
//     final modifiedRequest = applyHeaders(request, header);
//
//     // write
//
//     return modifiedRequest;
//   }
//
//   @override
//   // TODO: implement onAuthenticationFailed
//   AuthenticationCallback? get onAuthenticationFailed => throw UnimplementedError();
//
//   @override
//   AuthenticationCallback? get onAuthenticationSuccessful => throw UnimplementedError();
//
// }
