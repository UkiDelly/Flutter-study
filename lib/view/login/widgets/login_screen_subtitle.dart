import 'package:flutter/material.dart';
import 'package:flutter_study/common/colors.dart';

class LoginScreenSubtitle extends StatelessWidget {
  const LoginScreenSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "이메일과 비밀번호를 입력해서 로그인해주세요!\n오늘도 성공적인 주문이 되길 :)",
      style: TextStyle(
        fontSize: 16,
        color: bodyTextColor,
      ),
    );
  }
}
