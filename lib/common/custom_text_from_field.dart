import 'package:flutter/material.dart';
import 'package:flutter_study/common/colors.dart';

class CustomTextFormFeild extends StatelessWidget {
  final String? hintText, errorText;
  final bool obcsureText, autofocuse;
  final ValueChanged<String>? onChanged;
  const CustomTextFormFeild(
      {super.key,
      this.hintText,
      this.errorText,
      this.obcsureText = false,
      this.autofocuse = false,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    //
    const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(color: inputBorderColor, width: 1));

    //
    return TextFormField(
      //
      obscureText: obcsureText,

      // 자동 포커스 해제
      autofocus: autofocuse,

      //
      onChanged: onChanged,

      //
      cursorColor: primaryColor,

      //
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          //
          hintText: hintText,
          hintStyle: const TextStyle(color: bodyTextColor, fontSize: 14.0),

          //
          errorText: errorText,

          //
          fillColor: inputBGColor,
          filled: true,

          // 모든 input 상태의 기본 스타일
          border: baseBorder,

          //
          enabledBorder: baseBorder,

          // focused 되어 있을때 border. baseBorder를 복사하여 BorderSide 요소를 복사하여 color만 변경
          focusedBorder: baseBorder.copyWith(
              borderSide: baseBorder.borderSide.copyWith(color: primaryColor))),
    );
  }
}
