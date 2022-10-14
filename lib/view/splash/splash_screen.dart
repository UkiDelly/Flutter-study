import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/colors.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/view/root/root_tab.dart';
import 'package:flutter_study/view/login/login_screen.dart';

import '../../common/secure_storage/secure_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late FlutterSecureStorage storage;

  //
  // check the token
  void checkToken() async {
    // get the token from the secure storage
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    //
    try {
      // call the api
      Response response = await Dio().post(
        '$api/auth/token',
        options: Options(headers: {'authorization': 'Bearer $refreshToken'}),
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: response.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const RootTab(),
        ),
        (route) => false,
      );
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  // delete the token
  void deleteToken() async {
    await storage.deleteAll();
  }

  @override
  void initState() {
    super.initState();
    storage = ref.read(secureStorageProvider);
    // deleteToken();
    checkToken();
    //
  }

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      backgroundColor: primaryColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Logo
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),

            //
            const SizedBox(
              height: 16,
            ),

            //
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
