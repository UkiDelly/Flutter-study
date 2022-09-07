import 'package:flutter/material.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/colors.dart';
import 'package:flutter_study/view/login/widgets/login_screen_subtitle.dart';
import 'package:flutter_study/view/login/widgets/login_screen_title.dart';

import '../common/custom_text_from_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // title
            const LoginScreenTitle(),

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

            // 비밀번호
            CustomTextFormFeild(
              hintText: "비밀번호를 입력해주세요",
              obcsureText: true,
              onChanged: (String value) {},
            ),

            //
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
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
    );
  }
}
