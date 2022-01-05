import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiConfig {
  static createInstance() {
    final options = BaseOptions(
      baseUrl: "https://api.github.com/search",
      connectTimeout: 12000,
      receiveTimeout: 12000,
    );
    final dioInstance = Dio(options);
    dioInstance.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dioInstance;
  }

  static Map<String, dynamic> toParameter(
    String query,
    int page,
  ) {
    return {
      "q": query,
      "per_page": 10,
      "page": page,
    };
  }
}
