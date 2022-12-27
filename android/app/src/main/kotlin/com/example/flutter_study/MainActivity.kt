package com.example.flutter_study

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

  // Flutter와 연결을 위한 config
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine){
    // Plugin에 flutter engine을 등록한다.
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    // 메소드 채널을 생성한다 이때 메소드 채널의 이름은 "com.example.flutter_study"으로 dart 코드에 만든 매소드 채널과 동일해야 한다.
    final MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.example.flutter_study");

    // 메소드 채널의 핸들러를 설정한다.
    // Flutter로부터의 메소드 호출 이벤트를 수신할 MethodCallHandler를 채널에 등록한다.
    channel.setMethodCallHandler(handler);
  }

  // 메소드 채널의 핸들러
  private MethodChannel.MethodCallHandler handler = (methodCall, result) -> {

    // 만약 메소드 이름이 "getPlatformVersion"이면 플랫폼 버전을 반환한다.
    if (methodCall.method.equals('getPlatformVersion')) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }


}
