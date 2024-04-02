import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http_parser/http_parser.dart';
import '../../screen/login_screen/login_screen.dart';
import '../../shard/components/tools.dart';
import '../errors/error_model.dart';
import '../errors/exceptions.dart';
import '../local/cache_helper.dart';

class DioHelper {
  static late Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.43.164:8000/api/',
        // baseUrl: 'http://he508kf1xfx.sn.mynetname.net:4146/api/',
        receiveDataWhenStatusError: true,
      ),
    );

    dio?.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            ToastManager.showToast('تم تسجيل الخروج من التطبيق ', ToastStates.ERROR);
            CacheHelper.removeData(key: 'token');
            Get.offAll(LoginScreen());
          }
          if (error.type == DioExceptionType.connectionError) {
            // ToastManager.showToast('تأكد من الاتصال بالانترنت', ToastStates.ERROR);
            // CacheHelper.removeData(key: 'token');
            // Get.offAll(LoginScreen());
          }
          if (error.type == DioExceptionType.connectionTimeout) {
            // ToastManager.showToast('تأكد من الاتصال بالانترنت', ToastStates.ERROR);
            // Get.back();
            // throw ServerException(errModel: ErrorModel.fromJson(error.response!.data));
          } else if (error.type == DioExceptionType.sendTimeout) {
            // ToastManager.showToast('انتهت فترة الطلب', ToastStates.ERROR);
            // Get.back();
            // throw ServerException(errModel: ErrorModel.fromJson(error.response!.data));
          } else if (error.type == DioExceptionType.receiveTimeout) {
            // ToastManager.showToast('انتهت فترة الطلب', ToastStates.ERROR);
            Get.back();
            throw ServerException(
                errModel: ErrorModel.fromJson(error.response!.data));
          } else if (error.type == DioExceptionType.cancel) {}

          return handler.next(error);
        },
      ),
    );

    dio?.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true));
  }



  static Future<Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json ',
      'Authorization': authorization
    };
    return await dio!.get(
      url,
      queryParameters: queryParameters,
    );
  }


  static Future<Response<dynamic>> post({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': authorization,
      // 'content-Type' : 'application/x-www-form-urlencoded'
      // 'Content-Type' : 'image/jpeg'
    };
      return await dio!.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
  }




  static Future<Response<dynamic>> put({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': authorization
      // 'Content-Type' : 'application/json',
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response<dynamic>> delete({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio!.delete(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
