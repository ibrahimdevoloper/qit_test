import 'package:dio/dio.dart';

class LoginApiService {
  late Dio _dio;

  LoginApiService() {
    _dio = Dio();
  }

  Future<Response> sendData(String email,String password) async {
    Response response = await _dio.post(
        'http://restapi.adequateshop.com/api/authaccount/login',
        data: {"email": email, "password": password});
    return response;
  }
}
