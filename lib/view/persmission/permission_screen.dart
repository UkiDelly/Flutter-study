import 'package:flutter/material.dart';
import 'package:flutter_study/basic/basic_screen.dart';
import 'package:flutter_study/data/color_data.dart';
// import 'package:flutter_study/view/persmission/widgets/permisson_info.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          const Text("접근 권한 허용", style: TextStyle(fontSize: 24, color: mainColor, fontWeight: FontWeight.bold)),

          //
          const SizedBox(
            height: 30,
          ),

          //
          Text(
            "놀아죠 이용을 위해 다음의\n접근 권한 허용이 필요합니다.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17),
          ),

          //
          const SizedBox(
            height: 100,
          ),

          // Storage Permission
          // const PermissionInfo(
          //   kind: "저장",
          //   description: '프로필, 사진첩 등 메모리에\n사진 데이터 저장',
          //   icon: Icons.save_alt,
          // ),

          // // Camera Permission
          // const PermissionInfo(
          //   kind: "카메라",
          //   description: '프로필,게시글 사진 등록',
          //   icon: Icons.camera_alt_outlined,
          // ),

          // // Call permission
          // const PermissionInfo(
          //   kind: "전화",
          //   description: '회원가입시 기기인증 상태 유지',
          //   icon: Icons.phone_in_talk_rounded,
          // ),

          const Spacer(),

          ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: ElevatedButton(

                // show permission window when pressed
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 70),
                ),
                child: const Center(
                    child: Text(
                  "확인",
                  style: TextStyle(fontSize: 18),
                ))),
          )
        ],
      ),
    ));
  }
}
