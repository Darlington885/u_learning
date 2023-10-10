import 'package:dio/dio.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';

class HttpUtil {
  // This is a singleton class
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() {
    return _instance;
  }
  late Dio dio;
  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: AppConstants.SERVER_API_URL,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {},
        contentType: "application/json: charset=utf-8",
        responseType: ResponseType.json);
    dio = Dio(options);
  }

  Future post(String path, {dynamic mydata, Map<String, dynamic>? queryParameters, Options? options}) async {

    Options requestOptions =options??Options();
    requestOptions.headers = requestOptions.headers?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if(authorization != null){
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(path, data: mydata, queryParameters: queryParameters, options: requestOptions);
    print("My response is ${response.toString()}");
    print("My status code is ${response.statusCode.toString()}");
    return response.data; // Note this data is not the same as the data above
  }

 Map<String, dynamic>? getAuthorizationHeader(){
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if(accessToken.isNotEmpty){
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
}
