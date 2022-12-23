import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/common/secure_storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage));

  return dio;
});

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
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('[REQ] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    // refreshToken 가져오기
    final refreashToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken이 존재하지 않을때
    if (refreashToken == null) {
      // handler.reject하면 에러 발생
      // 즉 에러를 던질때는 handler.reject()을 써야함
      return handler.reject(err);

      //
      // handler.resolve(response) 이렇게 return 하면 에러가 발생해도 에러가 발생 안한 것처럼 할 수 있다.
    }

    // 401에서이면 true, 아니면 null
    final isStatus401 = err.response?.statusCode == 401;

    // 요청이 token을 가져오는것이라면,
    final isHaveRefresh = err.requestOptions.path == '/auth/token';

    // refresh 하려고 한건 아닌데 401 에러가 나오면,
    if (isStatus401 && !isHaveRefresh) {
      // refreshToken을 이용해서 새로운 accessToken을 받아오기
      final dio = Dio();
      try {
        final resp = await dio.post(
          '$api/auth/token',
          options: Options(
            headers: {'authroization': 'Bearer $refreashToken'},
          ),
        );

        // accessToken 가져오기
        final accessToken = resp.data['accessToken'];

        // 에러가 발생한 모든 요청의 옵션을 가져와서
        final options = err.requestOptions;

        // 새로운 accessToken으로 교체
        options.headers.addAll({'authorization': 'Bearer $refreashToken'});

        // 요청 재전송
        final response = await dio.fetch(options);

        // secure storage에 새로운 accessToken 저장
        storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }

    // 401 에러가 났을때 (status code)
    // 토큰을 재발급 또는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰을 요청

    return super.onError(err, handler);
  }
}
