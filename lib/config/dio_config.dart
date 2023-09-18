import 'package:dio/dio.dart';

class DioConfiguration {
  static Dio createRequest() {
    Dio dio = Dio(BaseOptions(
      validateStatus: (state) {
        if (state != null) {
          if (state >= 100 && state <= 511)
            return true;
          else
            return false;
        }
        return false;
      },
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ));

    return dio;
  }
}
