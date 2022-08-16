import 'package:flutter/material.dart';
import 'package:flutter_study/model/user_model.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<User> user = [
    User(
        name: "Dae Hyeon Song",
        urlImage:
            "https://cdn.ppomppu.co.kr/zboard/data3/2021/0312/m_20210312155001_hnzzarpd.jpg"),
    User(
        name: "Yeona",
        urlImage:
            "https://thumbnews.nateimg.co.kr/view610///onimg.nate.com/orgImg/td/2018/10/26/1540553355_1408877.jpg"),
    User(
        name: "Yeonmi",
        urlImage:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/170923_KCON_2017_Australia_%28cropped%29.jpg/250px-170923_KCON_2017_Australia_%28cropped%29.jpg")
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        //
        appBar: AppBar(
          title: const Text("Flutter Value Key"),
          centerTitle: true,
        ),

        //
        body: ReorderableListView.builder(
            itemBuilder: (context, index) {
              return userListTitle(index, user[index]);
            },
            itemCount: user.length,
            onReorder: (oldIndex, newIndex) => setState(() {
                  // 새 인덱스가 이전 인덱스보다 클 경우, 새 인덱스 -1의 인덱스를 저장, 아닐경우 새로운 인덱스를 저장.
                  final index = newIndex > oldIndex ? newIndex - 1 : newIndex;

                  // 이전 인덱스의 user를 List에서 제거한 후 _user에 저장
                  final _user = user.removeAt(oldIndex);

                  // 삭제한 user를 새로운 인덱스에 넣음.
                  user.insert(index, _user);
                })),
      );

  Widget userListTitle(int index, User user) => ListTile(
        // 각 ListTile
        key: ValueKey(user.name),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: const CircleAvatar(
          // backgroundImage: NetworkImage(user.urlImage),
          radius: 30,
        ),
        title: Text(user.name),
      );
}
