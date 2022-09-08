import 'package:flutter/material.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/colors.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/common/root_tab.dart';
import 'package:flutter_study/view/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  // check the token
  void checkToken() async {
    // get the token from the secure storage
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // go to login page if the token is null
    if (refreshToken == null || accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => RootTab(),
          ),
          (route) => false);
    }
  }

  // delete the token
  void deleteToken() async {
    await storage.deleteAll();
  }

  @override
  void initState() {
    super.initState();
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
            SizedBox(
              height: 16,
            ),

            //
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
