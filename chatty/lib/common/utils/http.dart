import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide FormData;

import '../store/store.dart';
import '../values/values.dart';
import 'utils.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions
    BaseOptions options = BaseOptions(
      //Base URL
      baseUrl: SERVER_API_URL,

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //Connection server timeout duration.
      connectTimeout: 30000,

      // The interval between receiving data on the response
      // stream for the previous and current times, measured in milliseconds.
      receiveTimeout: 30000,

      // Http Request header.
      headers: {},

      /// The Content-Type of the request, with the default value being
      /// 'application/json; charset=utf-8'. If you want to encode the request
      ///  data in the 'application/x-www-form-urlencoded' format, you can
      ///  set this option to Headers.formUrlEncodedContentType. By doing so,
      ///  [Dio] will automatically encode the request body.
      contentType: 'application/json; charset=utf-8',

      ///[responseType] indicates the expected format or method to receive response data. Currently,
      /// [ResponseType] accepts three types: JSON, STREAM, PLAIN.

      ///The default value is JSON. When the content-type in the
      ///response header is 'application/json', Dio will automatically convert the response content into a JSON object.

      ///If you want to receive response data in binary format, such as
      /// downloading a binary file, you can use STREAM.

      ///If you want to receive response data in plain
      ///text (string) format, please use PLAIN.
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // Cookie management
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    // add interceptors.
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before request is sent
        return handler.next(options); //continue
        // If you want to complete the request and return some custom data,
        //you can resolve a Response object using handler.resolve(response).
        //This way, the request will be terminated, and the upper-level then will be invoked.
        // The data returned in then will be your custom response.

        // If you want to abort the request and trigger an error,
        //you can return a DioError object, such as handler.reject(error).
        //This way, the request will be aborted and an exception will be thrown,
        //causing the upper-level catchError to be invoked.
      },
      onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
        // If you want to abort the request and trigger an error,
        //you can reject a DioError object by using handler.reject(error).
        //This way, the request will be aborted and an exception will be thrown,
        //causing the upper-level catchError to be invoked.
      },
      onError: (DioError e, handler) {
        // Do something with response error
        Loading.dismiss();
        ErrorEntity eInfo = createErrorEntity(e);
        onError(eInfo);
        return handler.next(e); //continue
        // If you want to complete the request and return some custom data,
        // you can resolve a Response object using handler.resolve(response).
        //This way, the request will be terminated, and the upper-level then will be invoked.
        //The data returned in then will be your custom response
      },
    ));
  }

  /*
   * error centralized handling.
   */

  // error handling
  void onError(ErrorEntity eInfo) {
    print('error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
    switch (eInfo.code) {
      case 401:
        UserStore.to.onLogout();
        EasyLoading.showError(eInfo.message);
        break;
      default:
        EasyLoading.showError('unknown error');
        break;
    }
  }

  // error message
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "request cancellation");
      case DioErrorType.connectTimeout:
        return ErrorEntity(code: -1, message: "connection timeout");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: "request timeout");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: "response timeout");
      case DioErrorType.response:
        {
          try {
            int errCode =
                error.response != null ? error.response!.statusCode! : -1;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                return ErrorEntity(
                    code: errCode, message: "request syntax error");
              case 401:
                return ErrorEntity(code: errCode, message: "unauthorized");
              case 403:
                return ErrorEntity(
                    code: errCode, message: "server refused to execute");
              case 404:
                return ErrorEntity(
                    code: errCode, message: "unable to connect to the server");
              case 405:
                return ErrorEntity(
                    code: errCode, message: "request method is not allowed");
              case 500:
                return ErrorEntity(
                    code: errCode, message: "internal server error");
              case 502:
                return ErrorEntity(code: errCode, message: "invalid request");
              case 503:
                return ErrorEntity(code: errCode, message: "server is down");
              case 505:
                return ErrorEntity(
                    code: errCode,
                    message: "HTTP protocol request not supported");
              default:
                {
                  // return ErrorEntity(code: errCode, message: "unknown error");
                  return ErrorEntity(
                    code: errCode,
                    message: error.response != null
                        ? error.response!.statusMessage!
                        : "",
                  );
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "unknown error");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  /*
   *Cancel Request

    *The same cancel token can be used for multiple requests. 
    *When a cancel token is canceled, all requests that use that 
    *cancel token will be canceled. Therefore, the parameter is optional.
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// read local configuration" or "fetch local settings.
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
      headers['Authorization'] = 'Bearer ${UserStore.to.token}';
    }
    return headers;
  }

  /// RESTful GET operation
  /// refresh: Whether it's a pull-down refresh. Default is false.
  /// noCache: Whether to disable caching. Default is true.
  /// list: Whether it's a list. Default is false.
  /// cacheKey: Cache key.
  /// cacheDisk: Whether to use disk caching.
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= Map();
    requestOptions.extra!.addAll({
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post operation
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );

    return response.data;
  }

  /// restful put operation
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful patch operation
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful delete operation
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post form data submission operation
  Future postForm(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post Stream  data submission operation
  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

// error handling
class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
