import 'package:dio/dio.dart';
const BASE_URL = 'http://www.devio.org/io/';

class HttpManager {
  Dio _dio;

  HttpManager(){
    if(_dio == null){
      BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        headers: {
          'token': ''
        }
      );
      _dio = Dio();
      _dio.interceptors.add(HttpInterceptors());
    }
  }

  Future get(String url, [Map<String, dynamic> params]) {
    return _dio.get(url, queryParameters: params == null ? {} : params);
  }

  Future post(String url, [Map<String, dynamic> params]){
    return _dio.post(url, data: params == null ? {} : params);
  }
}

class HttpInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    print('请求baseUrl:${options.baseUrl} ${options.path}${options.headers.toString}');
    return super.onRequest(options);
  }
 
  //  @override
  // onResponse(Response response) {
  //   print('响应${response.toString()}');
  //   RequestOptions option = response.request;
  //   try {
  //     ///一般只需要处理200的情况，300、400、500保留错误信息
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       int code = response.data["code"];
  //       return response.data["data"];
  //     }
  //   } catch (e) {
  //     print(e.toString() + option.path);
  //     return null;
  //     // return ResultData(code, response.msg, response.data);;
  //   }
  //   return super.onResponse(response);
  //   // return ResultData(code, response.msg, response.data);;
  // }
  @override
  Future onError(DioError err) {
    print(err.toString());
    // TODO: implement onError
    return super.onError(err);
    
  }
}
