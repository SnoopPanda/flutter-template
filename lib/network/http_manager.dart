import 'package:dio/dio.dart';
import 'package:my_flutter_template/network/address.dart';

class HttpManager {
  HttpManager._internal();
  
  static final Dio dio = Dio(BaseOptions(
    baseUrl: Address.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000
  ));
}