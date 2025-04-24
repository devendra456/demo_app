import 'package:demo_app/app/core/app_const.dart';
import 'package:dio/dio.dart';

class ApiBaseClient {
  static final BaseOptions _opts = BaseOptions(
    baseUrl: AppConst.baseUrl,
    responseType: ResponseType.json,
    contentType: "application/json",
  );

  static Dio _createDio() {
    return Dio(_opts);
  }

  static Dio _addInterceptors(Dio dio) {
    return dio;
  }

  static final _dio = _createDio();

  static Dio client = _addInterceptors(_dio);
}
