import 'package:flutter/material.dart';
import 'package:flutter_study/common/custom_text_from_field.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        //
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ));
  }
}


// Server Repo
// "https://github.com/codefactory-co/flutter-lv2-server"


// Flutter repo

// "https://github.com/codefactory-co/flutter-lv2-rest-api"