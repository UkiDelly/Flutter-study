import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/colors.dart';
import 'package:flutter_study/view/login/widgets/login_screen_subtitle.dart';
import 'package:flutter_study/view/login/widgets/login_screen_title.dart';
import '../common/custom_text_from_field.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  hintText: "이메일을 입력해주세요",
                  onChanged: (String value) {},
                ),

                //
                const SizedBox(
                  height: 16,
                ),

                // 비밀번호
                CustomTextFormFeild(
                  hintText: "비밀번호를 입력해주세요",
                  obcsureText: true,
                  onChanged: (String value) {},
                ),

                //
                const SizedBox(
                  height: 16,
                ),

                //
                ElevatedButton(
                  onPressed: () async {
                    // id:password
                    const rawString = 'test@codefactory.ai:testtest';

                    // create an Base64 encoder
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    // convert
                    String token = stringToBase64.encode(rawString);

                    //
                    try {
                      // call the api
                      var response = await http.post(Uri.parse(loginApi),
                          headers: {'authorization': 'Basic $token'});

                          

                      print(response.body);
                    } catch (e) {
                      print(e);
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text("로그인"),
                ),

                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: primaryColor),
                  child: const Text("회원가입"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
