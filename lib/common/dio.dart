import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_study/common/data.dart';

// Dio의 Interceptor를 중간에 가로채기
class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  CustomInterceptor({required this.storage});

  // 1) 요청을 보낼때
  // 요청이 보내질때마다
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    // headers에 accessToken 값이 true로 들어오면,
    if (options.headers['accessToken'] == 'true') {
      // accessToken 헤더 제거
      options.headers.remove('accessToken');

      // secure storage에서 실제 accessToken 가져와서
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // headers에 추가하기
      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    if (options.headers['refreshToken'] == 'true') {
      // refreshToken 헤더 제거
      options.headers.remove('refreshToken');

      // secure storage에서 실제 accessToken 가져와서
      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // headers에 추가하기
      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    // 요청 보냄
    return super.onRequest(options, handler);
  }
// 2) 응답을 받을때
// 3) 에러가 났을때

}
