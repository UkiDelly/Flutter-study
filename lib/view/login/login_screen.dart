import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/colors.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/common/secure_storage/secure_storage.dart';
import 'package:flutter_study/view/root/root_tab.dart';
import 'package:flutter_study/view/login/widgets/login_screen_subtitle.dart';
import 'package:flutter_study/view/login/widgets/login_screen_title.dart';
import '../../common/custom_text_from_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  //
  String username = '', password = '';

  //
  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      // 키보드 올라올 공간을 만들기 위해 SingleChildScrollView로 감싼다.
      child: SingleChildScrollView(
        // 드래그하면 키보드가 내려가게 설정
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // title
                const LoginScreenTitle(),
                //
                const SizedBox(),
                //
                const SizedBox(
                  height: 16,
                ),

                // subtitle
                const LoginScreenSubtitle(),

                // image
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width * (3 / 2),
                ),

                // 이메일
                CustomTextFormFeild(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String value) {
                    username = value;
                  },
                ),

                //
                const SizedBox(
                  height: 16,
                ),

                // 비밀번호
                CustomTextFormFeild(
                  hintText: '비밀번호를 입력해주세요',
                  obcsureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),

                //
                const SizedBox(
                  height: 16,
                ),

                //
                ElevatedButton(
                  onPressed: () async {
                    // id:password
                    final rawString = '$username:$password';

                    // create an Base64 encoder
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    // convert the string to token
                    String token = stringToBase64.encode(rawString);

                    //
                    try {
                      // call the api
                      Response response = await Dio()
                          .post('$api/auth/login', options: Options(headers: {'authorization': 'Basic $token'}));

                      // get the refresh & access token
                      final refreshToken = response.data['refreshToken'];
                      final accessToken = response.data['accessToken'];

                      final storage = ref.read(secureStorageProvider);

                      // storage the token in the secure storage
                      await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                      await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RootTab(),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text('로그인'),
                ),

                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(foregroundColor: primaryColor),
                  child: const Text('회원가입'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
