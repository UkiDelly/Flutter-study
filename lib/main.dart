import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'Flutter study', home: Container());
//   }
// }

class MyApp extends MaterialApp {
  const MyApp({Key? key}) : super(key: key, title: 'Method Channel Test', home: const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 메소드 채널 생성
  // 채널 이름은 안드로이드/IOS에서도 동일하게 사용해야 통신이 가능함
  // 다른 앱들간의 간섭을 피하기 위해 패키지명으로 채널 이름을 설정하는 것이 좋음
  static const MethodChannel channel = MethodChannel('com.example.flutterstudy/methodChannel');

  String platformVersion = 'Unknown';

  // 메소드 채널에서 데이터를 받아오는 함수 생성
  Future<String> getPlatformVersion() async {
    // 메소드 채널에서 데이터를 받아오는 함수 호출
    final String version = await channel.invokeMethod('getPlatformVersion');
    return version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method Channel Test'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                String result = await getPlatformVersion();
                setState(() {
                  platformVersion = result;
                });
              },
              child: const Text('Get Platform Version'),
            ),
            const SizedBox(height: 20),
            Text(platformVersion),
          ],
        ),
      ),
    );
  }
}
