import 'package:dio/dio.dart';
import 'package:my_flutter_template/common/Config.dart';
import 'package:my_flutter_template/network/result.dart';
import 'package:my_flutter_template/network/target_type.dart';

class HttpManager {
  static const connectTimeout = 15000;

  Dio dio;

  /// 单例
  // 工厂模式
  factory HttpManager() => _getInstance();

  static HttpManager get instance => _getInstance();
  static HttpManager _instance;

  HttpManager._internal() {
    // 初始化
  }

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
      _instance.dio = Dio(BaseOptions(
        baseUrl: Config.baseUrl,
        connectTimeout: connectTimeout,
      ));
      // _instance.dio.interceptors.add(LogInterceptors());
    }
    return _instance;
  }

  request(TargetType targetType) async {
    try {
      Response response;

      if (targetType.headers != null) {
        dio.options.headers = targetType.headers;
      }

      switch (targetType.method) {
        case HTTPMethod.POST:
          dio.options.method = "POST";
          break;
        case HTTPMethod.GET:
          dio.options.method = "GET";
          break;
        case HTTPMethod.PATCH:
          dio.options.method = "PATCH";
          break;
        case HTTPMethod.UPLOAD:
          dio.options.method = "UPLOAD";
          break;
        case HTTPMethod.DOWNLOAD:
          dio.options.method = "DOWNLOAD";
          break;
        case HTTPMethod.DELETE:
          dio.options.method = "DELETE";
          break;
      }

      if (targetType.parameters != null) {
        switch (targetType.encoding) {
          case ParameterEncoding.URLEncoding:
            response = await dio.request(targetType.path,
                queryParameters: targetType.parameters);
            break;
          case ParameterEncoding.BodyEncoding:
            response =
                await dio.request(targetType.path, data: targetType.parameters);
            break;
        }
      } else {
        response = await dio.request(targetType.path);
      }

      return Result(ResultType.success, data: response.data);
    } catch (exception) {
      try {
        DioError error = exception;
        Map dict = error.response.data;
        var message = dict["message"];
        return Result(ResultType.failed,
            errorMsg: (message == null) ? "网络请求失败, 请重试" : message);
      } catch (error) {
        return Result(ResultType.failed, errorMsg: "网络请求失败, 请重试");
      }
    }
  }
}
